import 'package:app_cinema_full/domain/entities/actor.dart';
import 'package:app_cinema_full/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {

  static Actor castToEntity(Cast cast) => 
  Actor
  (
    id: cast.id,
    name: cast.name,
    character: cast.character,
    profilePath: (cast.profilePath != null) // si es diferente de null
    ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}' // muestros muestro esto
    : 'https://cdn-icons-png.flaticon.com/512/149/149071.png' // si no muestro esto

  );


}