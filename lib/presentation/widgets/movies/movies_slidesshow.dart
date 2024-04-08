import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
// import animate_do
import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart'; 
class MoviesSlideshow extends StatelessWidget {
  
  final List<Movie> movies; // listado de peliculas

  const MoviesSlideshow({super.key, required this.movies});


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
    
      height: 200, 
      width: double.infinity, 
      child: Swiper(
        pagination:  SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            
            activeColor: colors.primary,
            color: colors.secondary.withOpacity(0.5)
          )
        
        ),
        viewportFraction: 0.7,
        scale: 0.8,
        autoplay: true,
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
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const[ BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset:  Offset(0, 10),
      )],
      

    );
    return Padding(
      padding: const EdgeInsets.only(bottom : 30),
      child: DecoratedBox(decoration: decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          movie.backdropPath, 
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress){
            if(loadingProgress == null) return child;
            return FadeIn(child: const CircularProgressIndicator());
          },
        )
      ),
        
      ),
    );  
  }
}