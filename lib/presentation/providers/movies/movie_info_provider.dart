import 'package:app_cinema_full/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cinema_full/domain/entities/movie.dart';



final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(movieRepository.getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId); // formato de la funcion que se va a pasar

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  
  final GetMovieCallback getMovie;

  MovieMapNotifier(
    this.getMovie) : super({});

  Future<void> loadMovie(String movieId) async {
    if ( state[movieId] != null) return;
    print ('cargando movie $movieId');
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};

  }
}