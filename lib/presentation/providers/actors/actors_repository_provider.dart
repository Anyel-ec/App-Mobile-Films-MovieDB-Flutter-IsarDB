

import 'package:app_cinema_full/domain/repositories/actors_repository.dart';
import 'package:app_cinema_full/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:app_cinema_full/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider<ActorsRepository>((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});