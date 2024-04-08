import 'package:app_cinema_full/domain/entities/movie.dart';

abstract class MoviesDatasource{
  Future<List<Movie>> getNowPlaying({int page = 1});

}