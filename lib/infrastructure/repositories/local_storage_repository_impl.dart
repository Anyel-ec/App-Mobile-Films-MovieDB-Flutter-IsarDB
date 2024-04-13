

import 'package:app_cinema_full/domain/datasources/local_storage_datasource.dart';
import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:app_cinema_full/domain/repositories/local_storage_repository.dart';
import 'package:app_cinema_full/infrastructure/datasources/isar_datasource.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository{

  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toogleFavorite(Movie movie) {
    return datasource.toogleFavorite(movie);
  }

}