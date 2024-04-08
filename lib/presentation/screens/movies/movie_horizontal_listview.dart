import 'package:animate_do/animate_do.dart';
import 'package:app_cinema_full/config/helpers/human_formats.dart';
import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? onNextPage;

  const MovieHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.onNextPage});

  @override
  State<MovieHorizontalListView> createState() => _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.onNextPage == null ) return ;

      if ( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        print ('Cargar siguientes peliculas');
        widget.onNextPage!();
      }
      
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 350,
        child: Column(
          children: [
            if (widget.title != null) _Title(title: widget.title, subTitle: widget.subTitle),
            Expanded(
                child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _Slide(movie: widget.movies[index]);
              },
            ))
          ],
        ));
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        //////////////////imagen/////////////////
        SizedBox(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(movie.posterPath,
                fit: BoxFit.cover,
                width: 150, 
                loadingBuilder: (context, child, loadingProgress) {

              if (loadingProgress == null) return FadeIn(child: child);
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }),
          ),
        ),

        const SizedBox(height: 5),
        SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

        ///rading
        SizedBox(
          width: 150,
          child: Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 5),
              Text (HumanFormants.number(movie.voteAverage), style: textStyles.bodyMedium?.copyWith(color: Colors.amber)),
              const Spacer(),
              Text (HumanFormants.number(movie.popularity), style: textStyles.bodyMedium),
            ],
          ),
        )
      ]
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({super.key, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
              style: const ButtonStyle( visualDensity: VisualDensity.compact ),
              onPressed: (){}, 
              child: Text( subTitle! )
            )
        ],
      ),
    );
  }
}
