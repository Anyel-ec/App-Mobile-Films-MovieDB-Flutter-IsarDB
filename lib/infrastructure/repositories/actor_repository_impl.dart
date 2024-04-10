

import 'package:app_cinema_full/domain/datasources/actors_datasource.dart';
import 'package:app_cinema_full/domain/entities/actor.dart';
import 'package:app_cinema_full/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource); // constructor

  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    return datasource.getActorByMovie(movieId);
  }
}