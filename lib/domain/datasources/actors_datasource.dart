import 'package:app_cinema_full/domain/entities/actor.dart';

abstract class ActorsDatasource {
  
  Future<List<Actor>> getActorByMovie(String movieId);

}