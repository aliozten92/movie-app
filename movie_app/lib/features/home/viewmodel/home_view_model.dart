import 'package:movie_app/core/base/base_view_model.dart';
import 'package:movie_app/core/models/movie.dart';
import 'package:movie_app/core/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends BaseViewModel {
  final List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  Set<int> get favoriteIds => _favoriteIds;

  final ApiService _apiService;
  final Set<int> _favoriteIds = {};

  HomeViewModel({required ApiService apiService}) : _apiService = apiService;

  @override
  Future<void> init() async {
    try {
      isLoading = true;
      await _apiService.initialize();
      final movies = await _apiService.getPopularMovies();
      _movies.clear();
      _movies.addAll(movies);
      await _loadFavorites();
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteIds = prefs.getStringList('favoriteIds') ?? [];
      _favoriteIds.clear();
      _favoriteIds.addAll(favoriteIds.map((id) => int.parse(id)));
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> toggleFavorite(int movieId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (_favoriteIds.contains(movieId)) {
        _favoriteIds.remove(movieId);
      } else {
        _favoriteIds.add(movieId);
      }
      await prefs.setStringList(
        'favoriteIds',
        _favoriteIds.map((id) => id.toString()).toList(),
      );
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      init();
      return;
    }

    try {
      isLoading = true;
      final searchResults = await _apiService.searchMovies(query);
      _movies.clear();
      _movies.addAll(searchResults);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
  }
}
