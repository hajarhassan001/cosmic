import 'package:cosmic/features/home/data/remote/datadase_firestore.dart';
import 'package:cosmic/features/inner_page/presentation/cubit/planet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanetDetailScreen extends StatelessWidget {
  final String planetName;

  const PlanetDetailScreen({super.key, required this.planetName});

  @override
  Widget build(BuildContext context) {
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
              return SingleChildScrollView(
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
                    Text(
                      planet.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(planet.info, style: const TextStyle(fontSize: 16)),
                    const Divider(height: 40),
                    _buildInfoRow("Order from sun", planet.order.toString()),
                    _buildInfoRow("Mass", "${planet.mass} ×10^24 kg"),
                    _buildInfoRow("Gravity", "${planet.gravity} m/s²"),
                    _buildInfoRow("Day length", "${planet.day} hours"),
                    _buildInfoRow("Velocity", "${planet.velocity} km/s"),
                    _buildInfoRow("Temperature", "${planet.temp} °C"),
                    _buildInfoRow("Distance", "${planet.distance} km"),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
