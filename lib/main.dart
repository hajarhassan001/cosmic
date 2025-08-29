import 'package:cosmic/core/routing/app_router.dart';

import 'package:cosmic/features/auth/cubit/auth-logic.dart';
import 'package:cosmic/features/auth/data_base/firebase_functions.dart';

import 'package:cosmic/features/favourites/remote/database_firebase.dart';


import 'package:cosmic/features/home/data/remote/datadase_firestore.dart';

import 'package:cosmic/features/home/presentation/cubit/home_cubit.dart';
import 'package:cosmic/features/favourites/cubit/favourites_cubit.dart';
import 'package:cosmic/features/inner_page/presentation/cubit/planet_cubit.dart';
import 'package:cosmic/features/notes/data/remote/notes_firebase.dart';
import 'package:cosmic/features/notes/presentation/cubit/notes_cubit.dart';
import 'package:cosmic/features/splash/splash_screen.dart';
import 'package:cosmic/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? "guest";
    final firebaseHomeService = FirebaseHomeService();
    final favouritesService = FavouritesService();

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<PlanetCubit>(
          create: (context) => PlanetCubit(FirebaseHomeService()),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(FirebaseFunctions()),
        ),

        BlocProvider<FavouritesCubit>(
          create: (_) {
            return FavouritesCubit(
              favouritesService,
              userId,
              firebaseHomeService,
            );
          },
        ),

        BlocProvider(
          create: (context) => NotesCubit(NotesService(), userId),
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
