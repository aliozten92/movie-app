import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/base/base_view.dart';
import 'package:movie_app/core/constants/size_constants.dart';
import 'package:movie_app/features/favorites/viewmodel/favorites_view_model.dart';
import 'package:movie_app/features/widgets/movie_card.dart';
import 'package:movie_app/features/widgets/shimmer_loading.dart';
import 'package:movie_app/core/localization/app_localization.dart';
import 'package:movie_app/core/services/api_service.dart';
import 'package:movie_app/core/router/app_router.dart';

class FavoritesView extends BaseView<FavoritesViewModel> {
  const FavoritesView({super.key});

  @override
  FavoritesViewModel createViewModel() => FavoritesViewModel(
        apiService: Provider.of<ApiService>(
          navigatorKey.currentContext!,
          listen: false,
        ),
      );

  @override
  Widget buildView(BuildContext context, FavoritesViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).translate('favorites.title')),
      ),
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(BuildContext context, FavoritesViewModel viewModel) {
    if (viewModel.isLoading) {
      return _buildLoadingGrid();
    }

    if (viewModel.errorMessage != null) {
      return Center(
        child: Text(AppLocalization.of(context).translate('favorites.error')),
      );
    }

    if (viewModel.movies.isEmpty) {
      return Center(
        child: Text(AppLocalization.of(context).translate('favorites.empty')),
      );
    }

    return _buildMovieGrid(viewModel);
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(Sizes.paddingM),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: Sizes.paddingM,
        mainAxisSpacing: Sizes.paddingM,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return const ShimmerLoading();
      },
    );
  }

  Widget _buildMovieGrid(FavoritesViewModel viewModel) {
    return GridView.builder(
      padding: const EdgeInsets.all(Sizes.paddingM),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: Sizes.paddingM,
        mainAxisSpacing: Sizes.paddingM,
      ),
      itemCount: viewModel.movies.length,
      itemBuilder: (context, index) {
        final movie = viewModel.movies[index];
        return GestureDetector(
          onTap: () {
            context.pushNamed(
              'movie_detail',
              extra: movie,
            );
          },
          child: MovieCard(
            movie: movie,
            isFavorite: true,
            onFavoritePressed: () => viewModel.toggleFavorite(movie.id),
          ),
        );
      },
    );
  }
}
