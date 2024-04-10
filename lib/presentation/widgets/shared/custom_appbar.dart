import 'package:app_cinema_full/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity, // <-- this line
          child: Row(
            children: [
              Icon(Icons.movie_creation, color: colors.primary),
              //const SizedBox(width: 10),
              // Text('Anyelmedia', style: titleStyle),
              const Spacer(),
              IconButton(
                onPressed: (){
                  showSearch(context: context, 
                  delegate: SearchMovieDelegate());
                },
               icon: Icon(Icons.search, color: colors.primary)
               )
            ],
          ),
        ),
      ),
    );
  }
}
