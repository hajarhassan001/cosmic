import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/features/favourites/cubit/favourites_cubit.dart';
import 'package:cosmic/features/home/data/remote/datadase_firestore.dart';
import 'package:cosmic/features/inner_page/presentation/cubit/planet_cubit.dart';
import 'package:cosmic/features/inner_page/presentation/widgets/add_note_part.dart';
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
                      "assets/images/image 10 (2).png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: height,

                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          const Color(0xff00E5E5).withOpacity(0.1),
                          const Color(0xff72A5F2).withOpacity(0.5),
                          const Color(0xffE961FF).withOpacity(0.7),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColor.surface.withOpacity(
                                0.5,
                              ),
                              child: IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            BlocBuilder<FavouritesCubit, FavouritesState>(
                              builder: (context, favState) {
                                final favCubit = context
                                    .read<FavouritesCubit>();
                                final isFav = favCubit.isFavourite(planet);

                                return CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppColor.surface.withOpacity(
                                    0.5,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      favCubit.toggleFavourite(planet);
                                    },
                                    icon: Icon(
                                      isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border_rounded,
                                      color: isFav ? Colors.red : Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.surface.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(28),
                                topRight: Radius.circular(28),
                              ),
                              border: Border.all(color: AppColor.surface),

                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.surface.withOpacity(0.5),
                                  blurRadius: 5,
                                  spreadRadius: 3,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            width: double.infinity,
                            height: height * 554 / 812,
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(height: height * 24 / 812),
                                  Text(
                                    planet.name,
                                    style: AppTextStyles.h1bold32,
                                  ),
                                  SizedBox(height: height * 29 / 812),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                  AddNotePart(planetName: planet.name),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: (width - 120) / 2,
                            top: -height * 60 / 812,
                            child: Image.network(
                              planet.image,
                              height: height * 120 / 812,
                              width: width * 120 / 375,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
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
          Text(value, style: AppTextStyles.h2bold24),
        ],
      ),
    );
  }
}
