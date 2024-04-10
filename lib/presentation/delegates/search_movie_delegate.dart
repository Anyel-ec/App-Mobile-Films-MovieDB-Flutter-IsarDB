

import 'package:animate_do/animate_do.dart';
import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query); // cumlir con la firma de la funcion

class SearchMovieDelegate extends SearchDelegate<Movie?>{

  final SearchMoviesCallback searchMovie;

  SearchMovieDelegate({super.searchFieldLabel, super.searchFieldStyle, super.searchFieldDecorationTheme, super.keyboardType, super.textInputAction, required this.searchMovie});

  @override
  String get searchFieldLabel => 'Buscar peliculas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //if (query.isNotEmpty)
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 250),
        child: IconButton(
          onPressed: (){
            query = '';
          },
          icon: const Icon(Icons.clear),
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(onPressed: (){
      close(context, null);
   }, icon: const Icon (Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text ('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovie(query),
     builder: ((context, snapshot){
      final movies = snapshot.data ?? [];
      return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return  _MovieItem(movie: movies[index]);
          
        },
      );
    }
    )
    );
  }
}


class _MovieItem extends StatelessWidget {

  final Movie movie;
  const _MovieItem({ required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8), 
      child: Row(children: [
        // image
        SizedBox(
          width: size.width * 0.2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              fit: BoxFit.cover,
          ),
          )
        )
      ],),
      );
  }
}
