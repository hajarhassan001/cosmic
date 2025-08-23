import 'package:cosmic/features/auth/log_in/log_in_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: [BlocProvider<HomeCubit>(create: (context) => HomeCubit())],

    //   child: MaterialApp(
    //     onGenerateRoute: AppRouter.generateRoute,

    //     home: const SplashScreen(),
    //   ),
    // );
    return MaterialApp(
      home: LogInScreen(),
    );

  }
}
