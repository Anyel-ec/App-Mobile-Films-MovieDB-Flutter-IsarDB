import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:app_cinema_full/config/helpers/human_formats.dart';
import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(
    String query); // cumlir con la firma de la funcion

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  // atributos
  final SearchMoviesCallback searchMovie;
  StreamController<List<Movie?>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debouncerTimer;
  List<Movie> initialMovies;

  SearchMovieDelegate(
      {required this.searchMovie, required this.initialMovies}); // constructor
  void clearStream() {
    debounceMovies.close();
  }

  void _onQueryChanged(String query) {
    isLoadingStream.add(true); // agregar un valor al stream
    if (_debouncerTimer?.isActive ?? false) {
      _debouncerTimer!.cancel();
    }
    _debouncerTimer = Timer(const Duration(milliseconds: 500), () async {
      // esperar 500 milisegundos para realizar la peticion

      if (kDebugMode) {
        // si el modo es debug
        print('Buscando $query'); // imprimir en consola
      }
      if (query.isEmpty) {
        // si el query es vacio
        debounceMovies.add([]); // agregar un array vacio
        return;
      }
      final movies = await searchMovie(query); // realizar la peticion
      debounceMovies.add(movies); // agregar la lista de peliculas
      initialMovies = movies; // asignar la lista de peliculas
      isLoadingStream.add(false); // agregar un valor al stream
    });
  }

////////////////////////////////////////////////////////////// widgets---------------------
  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
        initialData: initialMovies,
        stream: debounceMovies.stream,
        builder: ((context, snapshot) {
          final movies = snapshot.data ?? [];
          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) => _MovieItem(
                    movie: movies[index]!,
                    onMovieSelected: (context, movie) {
                      clearStream();
                      close(context, movie);
                    },
                  ));
        }));
  }

  @override
  String get searchFieldLabel => 'Buscar peliculas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //  cuando se comienze a escribir se mostrara un icono de refrescar, cuando no escriba se muestra la x
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
            if ( snapshot.data ?? false ) {
              return SpinPerfect(
                  duration: const Duration(seconds: 20),
                  spins: 20,
                  infinite: true,
                  child: IconButton(
                    onPressed: () => query = '', 
                    icon: const Icon( Icons.refresh_rounded )
                  ),
                );
            }

             return FadeIn(
                animate: query.isNotEmpty,
                child: IconButton(
                  onPressed: () => query = '', 
                  icon: const Icon( Icons.clear )
                ),
              );

        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStream();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions();
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;
  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            // image
            SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.posterPath,
                    loadingBuilder: (context, child, loadingProgress) =>
                        FadeIn(child: child),
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                )),

            // descripcion
            const SizedBox(
              width: 10,
            ),

            SizedBox(
                width: size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textTheme.titleMedium),
                    Text(
                      movie.overview,
                      style: textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        Text(HumanFormants.number(movie.voteAverage),
                            style: textTheme.bodyMedium),
                        const SizedBox(
                          width: 10,
                        ),
                        // texto de Anyel EC con color de texto opaco de azul
                        //const Text('Anyel EC', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w200),)
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
