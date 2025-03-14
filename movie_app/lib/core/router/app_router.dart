import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:movie_app/core/services/api_service.dart';
import 'package:movie_app/features/home/view/home_view.dart';
import 'package:movie_app/features/home/viewmodel/home_view_model.dart';
import 'package:movie_app/features/favorites/view/favorites_view.dart';
import 'package:movie_app/features/favorites/viewmodel/favorites_view_model.dart';
import 'package:movie_app/features/movie_detail/view/movie_detail_view.dart';
import 'package:movie_app/features/movie_detail/viewmodel/movie_detail_view_model.dart';
import 'package:movie_app/core/models/movie.dart';

final _logger = Logger();

final navigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  observers: [GoRouterObserver()],
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const FavoritesView(),
    ),
    GoRoute(
      path: '/movie/:id',
      name: 'movie_detail',
      builder: (context, state) {
        final movie = state.extra as Movie;
        return MovieDetailView(movie: movie);
      },
    ),
  ],
);

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i('Yeni sayfa açıldı: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i('Sayfa kapatıldı: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logger.i('Sayfa değiştirildi: ${newRoute?.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i('Sayfa kaldırıldı: ${route.settings.name}');
  }
}
