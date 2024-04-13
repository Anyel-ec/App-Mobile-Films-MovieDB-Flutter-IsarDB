import 'package:app_cinema_full/domain/datasources/local_storage_datasource.dart';
import 'package:app_cinema_full/domain/entities/movie.dart';
import 'package:isar/isar.dart';

class IsarDatasource extends LocalStorageDatasource {
  late Future<Isar> db; // late es para que no se inicialice en el constructor

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], inspector: true, directory: 'isar');
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    // esperar a que se resuelva la promesa

    final isar = await db; // esperamos que db se resuelva
    final Movie? isFavoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movieId)
        .findFirst(); // buscamos la pelicula por id

    return isFavoriteMovie !=
        null; // si la pelicula es diferente de null, es favorita
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db; // esperamos que db se resuelva
    return isar.movies
        .where()
        .offset(offset)
        .limit(limit)
        .findAll(); // buscamos todas las peliculas
  }

  @override
  Future<void> toogleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie = await isar.movies
        .filter()
        .idEqualTo(movie.id)
        .findFirst(); // buscamos la pelicula por id

    if (favoriteMovie != null) {
      // si la pelicula es diferente de null
      isar.writeTxnSync(() => isar.movies.delete(favoriteMovie.isarId!)); // la eliminamos
      return;
    }

    // insertar
    isar.writeTxnSync(() => isar.movies.putSync(movie)); // sincrono
  }
}
