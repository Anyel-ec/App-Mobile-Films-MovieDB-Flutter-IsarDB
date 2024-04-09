import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:app_cinema_full/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          strokeWidth: 2,
        )),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSleverAppBar(movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1, // solo tener un items
          ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  // centrar la imagen en el medio de la pantalla
                  movie.backdropPath,
                  width: (size.width - 40) * 0.3,
                  height: (size.width - 40) * 0.3 * 1.5,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 8),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  children: [
                    Text(
                      movie.title,
                      style: textStyle.titleLarge,
                    ),
                    Text(movie.overview),
                  ],
                ),
              ),

              // TODO: mostrar los actores ListView
              const SizedBox(height: 100),

              // Descripcion de la pelciukas
            ],
          ),
        ),
        Center(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                children: [
                  ...movie.genreIds.map((gender) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Chip(
                          label: Text(gender),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )
                        ),
                      ))
                ],
              )),
        )
      ],
    );
  }
}

class _CustomSleverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSleverAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      title: Text(movie.title, maxLines: 2),
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        // flexibleSpaceBar: es el contenedor que se expande
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 15),
        //   textAlign: TextAlign.start,
        //   maxLines: 2,
        // ),
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        background: Stack(
          children: [
            SizedBox.expand(
                child: Image.network(
              movie.posterPath,
              fit: BoxFit.fill,
            )),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.7,
                        1.0
                      ],
                      colors: [
                        Colors.transparent,
                        Colors.black87,
                      ]),
                ),
              ),
            ),

            ////////////////////
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      // que aparecezca en el navbar en el titulo
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        0.3
                      ],
                      colors: [
                        Colors.black87,
                        Colors.transparent,
                      ]),
                ),
              ),
            ),

            const SizedBox(
              height: 50,
            ),

            // generos de la pelicula
          ],
        ),
      ),
    );
  }
}
