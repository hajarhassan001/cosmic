import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/routing/routes.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:cosmic/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListviewPart extends StatelessWidget {
  final String? selectedName;

  const ListviewPart({super.key, required this.selectedName});

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;

    final List<Map<String, String>> planets = [
      {"name": "Mercury", "image": "assets/images/planet.png"},
      {"name": "Venus", "image": "assets/images/planet (1).png"},
      {"name": "Earth", "image": "assets/images/planet (2).png"},
      {"name": "Mars", "image": "assets/images/planet (3).png"},
      {"name": "Jupiter", "image": "assets/images/planet (1).png"},
      {"name": "Saturn", "image": "assets/images/planet (2).png"},
      {"name": "Uranus", "image": "assets/images/planet (3).png"},
      {"name": "Neptune", "image": "assets/images/planet.png"},
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: planets.length,
      itemBuilder: (context, index) {
        final planet = planets[index];
        final name = planet["name"]!;
        final image = planet["image"]!;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              context.read<HomeCubit>().selectPlanet(name);
              Navigator.pushNamed(
                context,
                Routes.planetScreen,
                arguments: name,
              );
            },
            child: Container(
              height: height * 48 / 812,
              width: width * 100 / 375,
              decoration: BoxDecoration(
                color: selectedName == name
                    ? AppColor.primaryColor.withOpacity(0.5)
                    : AppColor.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColor.surface),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: height * 35 / 812,
                      width: width * 35 / 375,
                      child: Image.asset(image),
                    ),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
