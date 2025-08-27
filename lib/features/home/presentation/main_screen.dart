import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/routing/routes.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/features/favourites/presentation/favourites_screen.dart';
import 'package:cosmic/features/home/presentation/cubit/home_cubit.dart';
import 'package:cosmic/features/home/presentation/home_screen.dart';
import 'package:cosmic/features/notes/presentation/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;

    final List<Widget> screens = [
      HomeScreen(),
      FavouritesScreen(),
      NotesScreen(),
    ];

    final List<String> titles = ["Solar System", "Favourites", "Notes"];
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        return Scaffold(
          body: Stack(
            children: [
              SizedBox.expand(
                child: Image.asset(
                  "assets/images/image 10.png",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.surface.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.surface.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 3,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: height * 128 / 812,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColor.surface.withOpacity(0.5),
                          child: Image.asset("assets/images/icon_settings.png"),
                        ),
                        Text(
                          titles[state.currentIndex],
                          style: AppTextStyles.h1bold32,
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColor.surface.withOpacity(0.5),
                          child: Image.asset("assets/images/icon_profile.png"),
                        ),
                      ],
                    ),
                  ),

                  screens[state.currentIndex],

                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.surface.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.surface.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 3,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    height: height * 74 / 812,
                    child: BottomNavigationBar(
                      backgroundColor: AppColor.surface.withOpacity(0.3),
                      selectedItemColor: AppColor.primaryColor,
                      unselectedItemColor: AppColor.textSecondary,
                      currentIndex: state.currentIndex,
                      onTap: (index) {
                        cubit.changeIndex(index);
                      },
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.favorite),
                          label: "Favourites",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.notes),
                          label: "Notes",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
