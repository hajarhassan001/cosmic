import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ListviewPart extends StatelessWidget {
  final String? selectedPlanetName;
  final Function(String) onSelect;

  const ListviewPart({
    super.key,
    required this.selectedPlanetName,
    required this.onSelect,
  });

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

        final isSelected = selectedPlanetName == name;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => onSelect(name),
            child: Container(
              height: height * 48 / 812,
              width: width * 95 / 375,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xff00C8B3)
                    : AppColor.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: height * 24 / 812,
                    width: width * 24 / 375,
                    child: Image.asset(image),
                  ),
                  Expanded(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
