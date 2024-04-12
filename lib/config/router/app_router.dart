import 'package:app_cinema_full/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        if (state.params['page'] == null) {
          return const HomeScreen(pageIndex: 0);
        }
        
        final  pageIndex = int.parse(state.params['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.name,
          builder: (context, state) {
            final String movieId = state.params['id'] ?? 'no-id';

            return MovieScreen(movieId: movieId);
          },
        ),
      ],
      
    ),

    GoRoute(
      path: '/', 
      redirect: (_ , __) => '/home/0',), // redirect to home

    

    
  ],
);
