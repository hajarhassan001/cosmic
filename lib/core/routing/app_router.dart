import 'package:cosmic/core/routing/routes.dart';
import 'package:cosmic/features/home/presentation/home_screen.dart'
    show HomeScreen;
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.loginScreen:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());

      // case Routes.registerScreen:
      //   return MaterialPageRoute(builder: (_) => const RegisterScreen());
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




