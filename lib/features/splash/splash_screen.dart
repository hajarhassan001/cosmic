import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/widgets/app_container_theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset("assets/images/Splash.png", fit: BoxFit.cover),
          ),
          Center(
            child: AppContainer(
              width: 200,
              height: 200,
              child: const Text(
                "Cosmic",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
