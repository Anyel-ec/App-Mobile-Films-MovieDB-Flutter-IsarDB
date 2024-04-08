import 'package:app_cinema_full/presentation/providers/movies/movies_providers.dart';
import 'package:app_cinema_full/presentation/providers/movies/movies_slidershow_provider.dart';
import 'package:app_cinema_full/presentation/widgets/shared/custom_bottom_navigationbar.dart';
import 'package:app_cinema_full/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// importar dotenv

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(), 
      bottomNavigationBar: CustomBottomNavigation(),
      );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return Column(
      children: [
        const CustomAppbar(),

        MoviesSlideshow(movies: slideShowMovies),
        MovieHorizontalListView(
          movies: nowPlayingMovies, 
          title: 'En cines', subTitle: 'Lunes',),


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
  }
}
