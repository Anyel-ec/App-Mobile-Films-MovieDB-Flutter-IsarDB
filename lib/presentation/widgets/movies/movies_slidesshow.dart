import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  
  final List<Movie> movies; // listado de peliculas

  const MoviesSlideshow({super.key, required this.movies});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
    
      height: 210, 
      width: double.infinity, 
      child: Swiper(
        viewportFraction: 0.6,
        scale: 0.4,
        autoplay: true,
        loop: false,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return _Slide(movie: movie);
        },

      ),
    );
  }
}


// ignore: unused_element
class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}