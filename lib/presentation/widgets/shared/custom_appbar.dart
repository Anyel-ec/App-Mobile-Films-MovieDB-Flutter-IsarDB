import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:app_cinema_full/presentation/delegates/search_movie_delegate.dart';
import 'package:app_cinema_full/presentation/providers/movies/movies_repository_provider.dart';
import 'package:app_cinema_full/presentation/providers/search/search_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    //final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity, // <-- this line
          child: Row(
            children: [
              //Icon(Icons.movie_creation, color: colors.primary),
              //const SizedBox(width: 10),
              // Text('Anyelmedia', style: titleStyle),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    final searchedMovie = ref.read(searchMoviesProvider);
                    final searchQuery = ref.read(searchQueryProvider);

                    showSearch<Movie?>(
                            context: context,
                            query: searchQuery,
                            delegate: SearchMovieDelegate(
                                initialMovies: searchedMovie,
                                searchMovie: ref
                                    .read(searchMoviesProvider.notifier)
                                    .searchMoviesByQuery))
                        .then((movie) {
                      if (movie != null) {
                        context.push('/home/0/movie/${movie.id}');
                      }
                    });
                  },
                  icon: Icon(Icons.search, color: colors.primary))
            ],
          ),
        ),
      ),
    );
  }
}
