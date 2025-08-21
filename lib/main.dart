import 'package:cosmic/core/routing/app_router.dart';
import 'package:cosmic/features/home/presentation/cubit/home_cubit.dart';
import 'package:cosmic/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<HomeCubit>(create: (context) => HomeCubit())],

      child: MaterialApp(
        onGenerateRoute: AppRouter.generateRoute,

        home: const SplashScreen(),
      ),
    );
  }
}
