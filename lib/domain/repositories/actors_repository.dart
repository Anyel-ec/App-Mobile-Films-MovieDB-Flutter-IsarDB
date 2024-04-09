import 'package:app_cinema_full/domain/entities/actor.dart';

abstract class ActorsRepository {
  
  Future<List<Actor>> getActorByMovie(String movieId);

}