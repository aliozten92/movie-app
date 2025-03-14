import 'package:flutter/material.dart';
import 'package:movie_app/core/base/base_view.dart';
import 'package:movie_app/core/localization/app_localization.dart';
import 'package:movie_app/core/models/movie.dart';
import 'package:movie_app/features/movie_detail/viewmodel/movie_detail_view_model.dart';

class MovieDetailView extends BaseView<MovieDetailViewModel> {
  final Movie movie;

  const MovieDetailView({
    super.key,
    required this.movie,
  });

  @override
  MovieDetailViewModel createViewModel() => MovieDetailViewModel(movie: movie);

  @override
  Widget buildView(BuildContext context, MovieDetailViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalization.of(context).translate('movie_detail.title')),
        actions: [
          IconButton(
            icon: Icon(
              viewModel.favoriteIds.contains(movie.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () => viewModel.toggleFavorite(movie.id),
          ),
        ],
      ),
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(BuildContext context, MovieDetailViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage != null) {
      return Center(
        child:
            Text(AppLocalization.of(context).translate('movie_detail.error')),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (movie.backdropPath != null)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 16),
          Text(
            movie.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            '${AppLocalization.of(context).translate('movie_detail.release_date')}: ${movie.releaseDate}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '${AppLocalization.of(context).translate('movie_detail.rating')}: ${movie.voteAverage}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalization.of(context).translate('movie_detail.overview'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            movie.overview,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
