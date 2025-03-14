import 'package:flutter/foundation.dart';
import 'package:movie_app/core/base/base_view_model.dart';
import 'package:movie_app/core/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailViewModel extends BaseViewModel {
  final Movie movie;
  final Set<int> _favoriteIds = {};
  Set<int> get favoriteIds => _favoriteIds;

  MovieDetailViewModel({required this.movie});

  @override
  Future<void> init() async {
    try {
      isLoading = true;
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
      _favoriteIds.addAll(
        favoriteIds.map((id) => int.parse(id)),
      );
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

      if (_favoriteIds.contains(movieId)) {
        _favoriteIds.remove(movieId);
        favoriteSet.remove(movieId.toString());
      } else {
        _favoriteIds.add(movieId);
        favoriteSet.add(movieId.toString());
      }

      await prefs.setStringList('favoriteIds', favoriteSet.toList());
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
    }
  }
}
