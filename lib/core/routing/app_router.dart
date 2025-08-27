import 'package:cosmic/core/routing/routes.dart';
import 'package:cosmic/features/auth/log_in/log_in_screen.dart';
import 'package:cosmic/features/favourites/presentation/favourites_screen.dart';
import 'package:cosmic/features/home/presentation/home_screen.dart';
import 'package:cosmic/features/home/presentation/main_screen.dart';
import 'package:cosmic/features/inner_page/presentation/planet_screen.dart';
import 'package:cosmic/features/notes/presentation/notes_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
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

      case Routes.favouritesScreen:
        return MaterialPageRoute(builder: (_) => const FavouritesScreen());

      case Routes.notesScreen:
        return MaterialPageRoute(builder: (_) => const NotesScreen());

      // case Routes.profileScreen:
      //   return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}


// Navigator.pushNamed(context, Routes.loginScreen);




