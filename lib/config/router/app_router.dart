import 'package:app_cinema_full/presentation/screens/movies/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/', 
  routes: [
    // Add your routes here
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    )
  ],
);
