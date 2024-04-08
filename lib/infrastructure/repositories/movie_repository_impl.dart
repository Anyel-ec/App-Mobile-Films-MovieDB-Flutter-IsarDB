


import 'package:app_cinema_full/domain/datasources/movies_datasource.dart';
import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:app_cinema_full/domain/repositories/movies_respository.dart';

class MovieRepositoryImpl extends MoviesRepository {

  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);

  
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }


}