

import 'package:app_cinema_full/domain/datasources/movies_datasource.dart';
import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MovieDatasource
{
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3', 
      queryParameters: {
        'apy_key': const String.fromEnvironment('MOVIEDB_API_KEY'), 
        'language': 'es-MX'
      }
      ));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final List<Movie> movies = [];
    return movies;
  }
  
}
