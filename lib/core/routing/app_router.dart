import 'package:cosmic/core/routing/routes.dart';
import 'package:cosmic/features/auth/log_in/log_in_screen.dart';
import 'package:cosmic/features/home/data/models/planet_model.dart';
import 'package:cosmic/features/home/presentation/home_screen.dart'
    show HomeScreen;
import 'package:cosmic/features/inner_page/presentation/planet_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final planet = settings.arguments as PlanetModel; // استقبل الكوكب

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LogInScreen());

      case Routes.planetScreen:
        final planetName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => PlanetDetailScreen(planetName: planetName),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      // case Routes.profileScreen:
      //   return MaterialPageRoute(builder: (_) => const ProfileScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}


// Navigator.pushNamed(context, Routes.loginScreen);




