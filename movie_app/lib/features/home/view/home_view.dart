import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/base/base_view.dart';
import 'package:movie_app/core/constants/size_constants.dart';
import 'package:movie_app/features/home/viewmodel/home_view_model.dart';
import 'package:movie_app/features/widgets/movie_card.dart';
import 'package:movie_app/features/widgets/shimmer_loading.dart';
import 'package:movie_app/core/localization/app_localization.dart';
import 'package:movie_app/core/providers/language_provider.dart';
import 'package:movie_app/core/services/api_service.dart';
import 'package:movie_app/core/router/app_router.dart';

class HomeView extends BaseView<HomeViewModel> {
  const HomeView({super.key});

  @override
  HomeViewModel createViewModel() {
    final context = navigatorKey.currentContext;
    if (context == null) {
      throw Exception('Context is not ready');
    }
    return HomeViewModel(
      apiService: context.read<ApiService>(),
    );
  }

  @override
  Widget buildView(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.of(context).translate('home.title')),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => context.pushNamed('favorites'),
          ),
          PopupMenuButton<String>(
            onSelected: (String languageCode) {
              context.read<LanguageProvider>().changeLanguage(languageCode);
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'tr',
                child: Text(
                    AppLocalization.of(context).translate('app.language') +
                        ': Türkçe'),
              ),
              PopupMenuItem<String>(
                value: 'en',
                child: Text(
                    AppLocalization.of(context).translate('app.language') +
                        ': English'),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.isLoading) {
      return _buildLoadingGrid(viewModel);
    }

    if (viewModel.errorMessage != null) {
      return Center(
        child: Text(AppLocalization.of(context).translate('home.error')),
      );
    }

    if (viewModel.movies.isEmpty) {
      return Center(
        child: Text(AppLocalization.of(context).translate('home.no_results')),
      );
    }

    return _buildMovieGrid(viewModel);
  }

  Widget _buildLoadingGrid(HomeViewModel viewModel) {
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
        return const ShimmerLoading();
      },
    );
  }

  Widget _buildMovieGrid(HomeViewModel viewModel) {
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
            isFavorite: viewModel.favoriteIds.contains(movie.id),
            onFavoritePressed: () => viewModel.toggleFavorite(movie.id),
          ),
        );
      },
    );
  }
}
