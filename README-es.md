# MovieDB App Movile Films in Flutter

Esta es una aplicación móvil desarrollada en Flutter que utiliza la API de The Movie Database (TMDb) para mostrar información sobre películas. La aplicación permite a los usuarios explorar películas populares, buscar películas por título, ver detalles de películas y marcar películas como favoritas.

## Configuración del entorno

La aplicación utiliza un archivo `.env` para almacenar la clave de la API de TMDb. Asegúrate de configurar esta clave en un archivo llamado `.env` en la raíz del proyecto:

```
THE_MOVIEDB_KEY=b7f5a860b7790e5e8817fe083853528d
```

## Librerías utilizadas

La aplicación hace uso de las siguientes librerías de Flutter:

- `animate_do: ^3.0.2`
- `card_swiper: ^3.0.1`
- `dio: ^5.0.0`
- `flutter_dotenv: ^5.0.2`
- `flutter_riverpod: ^2.2.0`
- `flutter_staggered_grid_view: ^0.7.0`
- `go_router: ^11.1.4`
- `intl: ^0.18.0`
- `isar: ^3.0.5`
- `isar_flutter_libs: ^3.0.5`
- `path_provider: ^2.1.1`

## Rutas de la aplicación

Las rutas de la aplicación están definidas utilizando `go_router`. Estas son las rutas principales:

- `/home/:page`: Página de inicio que muestra películas según la página especificada.
- `/movie/:id`: Página de detalles de la película.

## Fuentes de datos de infraestructura

La aplicación utiliza diferentes fuentes de datos para obtener información sobre películas y actores. Algunas de estas fuentes incluyen:

- `MoviedbDatasource`: Obtiene información sobre películas utilizando la API de TMDb.
- `ActorMovieDbDatasource`: Obtiene información sobre actores de las películas utilizando la API de TMDb.
- `IsarDatasource`: Maneja la persistencia local de datos utilizando la base de datos Isar.

## Repositorios

Los repositorios se encargan de coordinar las fuentes de datos y proporcionar la información necesaria a las capas superiores de la aplicación. Algunos ejemplos de repositorios son:

- `MovieRepositoryImpl`: Implementa métodos para obtener diferentes tipos de películas (populares, mejor valoradas, etc.).
- `ActorRepositoryImpl`: Implementa métodos para obtener actores de películas.

## Delegados de búsqueda

La aplicación utiliza un delegado de búsqueda personalizado para permitir a los usuarios buscar películas por título. El delegado maneja la lógica de búsqueda y muestra los resultados en tiempo real.

## Pantallas principales

La aplicación cuenta con las siguientes pantallas principales:

- `HomeScreen`: Pantalla principal que muestra diferentes categorías de películas y permite a los usuarios navegar entre ellas.
- `MovieScreen`: Pantalla que muestra detalles de una película específica, incluida su sinopsis, elenco y géneros.

## Componentes personalizados

La aplicación incluye varios componentes personalizados, como listas horizontales de películas, barras de navegación personalizadas y detalles de películas enriquecidos con imágenes y texto.

