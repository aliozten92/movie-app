import 'package:flutter/foundation.dart';
import 'package:movie_app/core/base/base_view_model.dart';
import 'package:movie_app/core/models/movie.dart';
import 'package:movie_app/core/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesViewModel extends BaseViewModel {
  final List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  final ApiService _apiService;

  FavoritesViewModel({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  @override
  Future<void> init() async {
    try {
      isLoading = true;
      await _loadFavoriteMovies();
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
    }
  }

  Future<void> _loadFavoriteMovies() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteIds = prefs.getStringList('favoriteIds') ?? [];
      _movies.clear();

      for (final id in favoriteIds) {
        try {
          final movie = await _apiService.getMovieDetails(int.parse(id));
          _movies.add(movie);
        } catch (e) {
          print('Error loading movie $id: $e');
        }
      }
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }

  Future<void> toggleFavorite(int movieId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteIds = prefs.getStringList('favoriteIds') ?? [];
      final Set<String> favoriteSet = favoriteIds.toSet();

      if (favoriteSet.contains(movieId.toString())) {
        favoriteSet.remove(movieId.toString());
        _movies.removeWhere((movie) => movie.id == movieId);
      }

      await prefs.setStringList('favoriteIds', favoriteSet.toList());
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }
}
