
import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:app_cinema_full/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final popularMoviesPopular = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getPopular;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getTopRated;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final upCommingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getUpComming;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});



typedef MovieCallback = Future<List<Movie>> Function({ int page });

class MoviesNotifier extends StateNotifier<List<Movie>> {
  
  int currentPage = 0;
  bool isLastPage = false;
  MovieCallback fetchMoreMovies;


  MoviesNotifier({
    required this.fetchMoreMovies,
  }): super([]);

  Future<void> loadNextPage() async{ // cargar la siguiente pagina
    if (isLastPage) return; // si es la ultima pagina no hacer nada
    isLastPage = true; // establecer que esta cargando
    currentPage++; // aumentar la pagina
    final List<Movie> movies = await fetchMoreMovies( page: currentPage ); // obtener las peliculas de la pagina actual
    state = [...state, ...movies]; // cambiar el estado
    await Future.delayed(const Duration(milliseconds: 300)); // esperar un segundo
    isLastPage = false; // establecer que ya no esta cargando
  }


}