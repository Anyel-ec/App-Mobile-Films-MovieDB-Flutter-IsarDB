import 'package:app_cinema_full/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_cinema_full/infrastructure/datasources/moviedb_datasource.dart';

final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl( MoviedbDatasource() );
  
});