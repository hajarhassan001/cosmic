import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ListviewPart extends StatelessWidget {
  final bool isSelelcted;
  final VoidCallback onSelect;
  const ListviewPart({
    super.key,
    required this.isSelelcted,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;

    List<Map<String, String>> planets = [
      {"name": "Mercury", "image": "assets/images/mercury.png"},
      {"name": "Venus", "image": "assets/images/venus.png"},
      {"name": "Earth", "image": "assets/images/earth.png"},
      {"name": "Mars", "image": "assets/images/mars.png"},
      {"name": "Jupiter", "image": "assets/images/jupiter.png"},
      {"name": "Saturn", "image": "assets/images/saturn.png"},
      {"name": "Uranus", "image": "assets/images/uranus.png"},
      {"name": "Neptune", "image": "assets/images/neptune.png"},
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: planets.length,
      itemBuilder: (context, index) {
        final planet = planets[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: onSelect,
            child: Container(
              height: height * 48 / 812,
              width: width * 95 / 375,
              decoration: BoxDecoration(
                color: isSelelcted
                    ? Color(0xff00C8B3)
                    : AppColor.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(28),
              ),

              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  planet["name"]!,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
