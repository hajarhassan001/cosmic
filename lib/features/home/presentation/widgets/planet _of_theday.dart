import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/routing/routes.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/core/widgets/app_container_theme.dart';
import 'package:cosmic/features/inner_page/presentation/cubit/planet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanetOfTheday extends StatelessWidget {
  const PlanetOfTheday({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;
    context.read<PlanetCubit>().getPlanetOfTheDay();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppContainer(
        width: width * 327 / 375,
        height: height * 230 / 812,
        child: BlocBuilder<PlanetCubit, PlanetState>(
          builder: (context, state) {
            if (state is PlanetLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlanetError) {
              return Center(child: Text(state.message));
            } else if (state is PlanetSuccess) {
              final planet = state.planet;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Planet of the day", style: AppTextStyles.h3bold18),

                  SizedBox(height: height * 8 / 812),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                 
                      Image.network(
                        planet.image,
                        width: width * 80 / 375,
                        height: height * 80 / 812,
                        fit: BoxFit.cover,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            planet.name,
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: width * 200 / 375,
                            height: height * 92 / 812,
                            child: Text(
                              planet.info,
                              style: AppTextStyles.bady12,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.planetScreen,
                        arguments: planet.name,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Details",
                          style: AppTextStyles.bady12.copyWith(
                            color: AppColor.textPrimary,
                          ),
                        ),
                        Image.asset(
                          "assets/images/icon_more.png",
                          height: height * 24 / 812,
                          width: width * 24 / 375,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
