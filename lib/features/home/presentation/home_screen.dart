import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/core/widgets/app_container_theme.dart';
import 'package:cosmic/features/home/presentation/cubit/home_cubit.dart';
import 'package:cosmic/features/home/presentation/widgets/listview_part.dart';
import 'package:cosmic/features/home/presentation/widgets/planet%20_of_theday.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: height * 60 / 812,
              child: ListviewPart(selectedName: state.selectedName),
            ),

            PlanetOfTheday(),
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
          ],
        );
      },
    );
  }
}
