import 'package:app_cinema_full/domain/entities/movie.dart';

abstract class MovieDatasource{
  Future<List<Movie>> getNowPlaying({int page = 1});

}