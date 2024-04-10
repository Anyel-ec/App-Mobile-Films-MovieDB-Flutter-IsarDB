import 'package:app_cinema_full/config/constants/environment.dart';
import 'package:app_cinema_full/domain/datasources/actors_datasource.dart';
import 'package:app_cinema_full/domain/entities/actor.dart';
import 'package:app_cinema_full/infrastructure/mappers/actor_mapper.dart';
import 'package:app_cinema_full/infrastructure/models/moviedb/credits_response.dart';
import 'package:app_cinema_full/infrastructure/models/moviedb/movie_details.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource{

  final dio = Dio(BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3',
        queryParameters: {
          'api_key': Environment.movieDbKey,
          'language': 'es-MX'
        }
      ));
 
  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    final response = await dio.get(
      '/movie/$movieId/credits'
      );
     

   
    final creditsResponse = CredistResponse.fromJson(response.data);
    List <Actor> actors = creditsResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();


    return actors;
  }



}