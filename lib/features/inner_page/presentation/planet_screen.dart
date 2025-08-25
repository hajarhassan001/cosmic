import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/features/home/data/remote/datadase_firestore.dart';
import 'package:cosmic/features/inner_page/presentation/cubit/planet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanetDetailScreen extends StatelessWidget {
  final String planetName;

  const PlanetDetailScreen({super.key, required this.planetName});

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;
    return BlocProvider(
      create: (_) =>
          PlanetCubit(FirebaseHomeService())..getPlanetByName(planetName),
      child: Scaffold(
        appBar: AppBar(title: Text(planetName)),
        body: BlocBuilder<PlanetCubit, PlanetState>(
          builder: (context, state) {
            if (state is PlanetLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlanetError) {
              return Center(child: Text(state.message));
            } else if (state is PlanetSuccess) {
              final planet = state.planet;
              return Stack(
                children: [
                  SizedBox.expand(
                    child: Image.asset(
                      "assets/images/image 10.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          planet.image,
                          height: 200,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(planet.name, style: AppTextStyles.h1bold32),
                        const SizedBox(height: 10),
                        Text(planet.info, style: AppTextStyles.h4bold18),
                        const Divider(height: 40),
                        Row(
                          children: [
                            _buildInfoRow(
                              "Mass",

                              "${planet.mass}",
                              "assets/images/icon_xl.png",
                              "(×10^24 kg)",
                            ),
                            _buildInfoRow(
                              "Gravity",
                              "${planet.gravity}",
                              'assets/images/icon_xl (1).png',
                              "(m/s²)",
                            ),
                            _buildInfoRow(
                              "Day length",
                              "${planet.day}",
                              "assets/images/icon_xl (2).png",
                              "(hours)",
                            ),
                          ],
                        ),
                        // _buildInfoRow(
                        //   "Order from sun",
                        //   planet.order.toString(),
                        // ),
                        Row(
                          children: [
                            _buildInfoRow(
                              "Velocity",

                              "${planet.velocity}",
                              "assets/images/icon_xl (3).png",
                              "(km/s)",
                            ),
                            _buildInfoRow(
                              "Temperature",

                              "${planet.temp}",
                              "assets/images/icon_xl (4).png",
                              "(°C)",
                            ),
                            _buildInfoRow(
                              "Distance",
                              "${planet.distance}",
                              "assets/images/icon_xl (5).png",
                              "(km)",
                            ),
                          ],
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

  Widget _buildInfoRow(String label, String value, String icon, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(child: Image.asset(icon)),

          Text(label, style: AppTextStyles.bady12),
          Text(unit, style: AppTextStyles.bady12),

          Text(value, style: AppTextStyles.h1bold32),
        ],
      ),
    );
  }
}
