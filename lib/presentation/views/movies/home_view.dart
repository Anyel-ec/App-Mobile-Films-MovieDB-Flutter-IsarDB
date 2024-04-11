import 'package:app_cinema_full/presentation/providers/movies/movies_slidershow_provider.dart';
import 'package:app_cinema_full/presentation/providers/providers.dart';
import 'package:app_cinema_full/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView();

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesPopular.notifier).loadNextPage();
    ref.read(upCommingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesPopular);
    final upCommingMovies = ref.watch(upCommingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
      const SliverAppBar(
        floating: true,
        elevation: 0,
        title: CustomAppbar(),
        centerTitle: true,
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              // const CustomAppbar(),

              MoviesSlideshow(movies: slideShowMovies),
              MovieHorizontalListView(
                movies: nowPlayingMovies,
                title: 'En cines',
                subTitle: 'Lunes',
                onNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),

              MovieHorizontalListView(
                movies: popularMovies,
                title: 'Populares',
                // subTitle: 'Lunes',
                onNextPage: () {
                  ref.read(popularMoviesPopular.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListView(
                movies: upCommingMovies,
                title: 'Mejor Calificadas',
                subTitle: 'Lunes',
                onNextPage: () {
                  ref.read(upCommingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizontalListView(
                movies: topRatedMovies,
                title: 'Proximamente',
                subTitle: 'Lunes',
                onNextPage: () {
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                },
              ),

              const SizedBox(height: 10)

              // Expanded(
              //     child: ListView.builder(
              //   itemCount: nowPlayingMovies.length,
              //   itemBuilder: (context, index) {
              //     final movie = nowPlayingMovies[index];
              //     return ListTile(
              //       title: Text(movie.title),
              //     );
              //   },
              // ))
            ],
          );
        },
        childCount: 1,
      ))
    ]);
  }
}
