import 'package:cosmic/core/routing/app_router.dart';
import 'package:cosmic/features/home/data/remote/datadase_firestore.dart';
import 'package:cosmic/features/home/presentation/cubit/home_cubit.dart';
import 'package:cosmic/features/inner_page/presentation/cubit/planet_cubit.dart';
import 'package:cosmic/features/splash/splash_screen.dart';
import 'package:cosmic/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<PlanetCubit>(
          create: (context) => PlanetCubit(FirebaseHomeService()),
        ),
      ],

      child: SafeArea(
        child: MaterialApp(
          onGenerateRoute: AppRouter.generateRoute,
          debugShowCheckedModeBanner: false,

          home: const SplashScreen(),
        ),
      ),
    );
  }
}
