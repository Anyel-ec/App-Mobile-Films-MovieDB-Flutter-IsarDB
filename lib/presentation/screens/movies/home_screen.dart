import 'package:app_cinema_full/config/constants/environment.dart';
import 'package:flutter/material.dart';
// importar dotenv

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(Environment.movieDbKey),
    ));
  }
}
