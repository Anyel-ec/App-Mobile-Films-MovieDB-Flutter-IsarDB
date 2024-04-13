


import 'package:app_cinema_full/domain/datasources/local_storage_datasource.dart';
import 'package:app_cinema_full/domain/entities/movie.dart';

class IsarDatasource extends LocalStorageDatasource{
  @override
  Future<bool> isMovieFavorite(int movieId) {
    // TODO: implement isMovieFavorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toogleFavorite(Movie movie) {
    // TODO: implement toogleFavorite
    throw UnimplementedError();
  }

}