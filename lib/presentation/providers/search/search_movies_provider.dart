import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:app_cinema_full/presentation/providers/movies/movies_repository_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {

  final movieRepository = ref.read(movieRepositoryProvider); // leer el provider de movies
  return SearchedMoviesNotifier(  
    searchMovies: movieRepository.searchMovies, // pasar la funcion de busqueda
    ref: ref, // pasar la referencia
  );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(
    String query); // firma de la funcion

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
      : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  }
}
