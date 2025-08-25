import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/routing/routes.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/core/widgets/app_container_theme.dart';
import 'package:cosmic/features/home/presentation/cubit/home_cubit.dart';
import 'package:cosmic/features/home/presentation/widgets/listview_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset("assets/images/image 10.png", fit: BoxFit.cover),
          ),
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();
              return Column(
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
                        Text("Solar System", style: AppTextStyles.h1bold32),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColor.surface.withOpacity(0.5),
                          child: Image.asset("assets/images/icon_profile.png"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 60 / 812,
                    child: ListviewPart(
                      selectedPlanetName: context
                          .watch<HomeCubit>()
                          .selectedPlanetName,
                      onSelect: (name) {
                        cubit.selectPlanet(name);
                        Navigator.pushNamed(
                          context,
                          Routes.planetScreen,
                          arguments: name,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppContainer(
                      width: width * 327 / 375,
                      height: height * 219 / 812,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Planet of the day",
                            style: AppTextStyles.h3bold18,
                          ),

                          SizedBox(height: height * 8 / 812),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: AppColor.surface.withOpacity(
                                  0.5,
                                ),
                                child: Image.asset(
                                  "assets/images/planet (3).png",
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mars",
                                    style: TextStyle(
                                      color: AppColor.primaryColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 200 / 375,
                                    height: height * 100 / 812,
                                    child: Text(
                                      "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, only being larger than Mercury. In the English language, Mars is named for the Roman god of war.",
                                      style: AppTextStyles.bady12,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "Details →",
                              style: AppTextStyles.bady12.copyWith(
                                color: AppColor.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppContainer(
                    width: width * 327 / 375,
                    height: height * 219 / 812,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Solar System", style: AppTextStyles.h3bold18),
                        SizedBox(height: height * 8 / 812),
                        Expanded(
                          child: Text(
                            "The Solar System[c] is the gravitationally bound system of the Sun and the objects that orbit it. It formed 4.6 billion years ago from the gravitational collapse of a giant interstellar molecular cloud. The vast majority (99.86%) of the system's mass is in the Sun, with most of the remaining mass contained in the planet Jupiter. The four inner system planets—Mercury, Venus, Earth and Mars—are terrestrial planets, being composed primarily of rock and metal. The four giant planets of the outer system are substantially larger and more massive than the terrestrials. ",
                            style: AppTextStyles.bady12,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          icon: Icon(Icons.more_horiz),
                          label: "More",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
