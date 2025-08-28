import 'package:cosmic/core/extentions/context_extention.dart';
import 'package:cosmic/core/routing/routes.dart';
import 'package:cosmic/core/theme/app_colors.dart';
import 'package:cosmic/core/theme/app_text_style.dart';
import 'package:cosmic/features/inner_page/presentation/cubit/favourites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.media.size;
    final width = size.width;
    final height = size.height;

    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        if (state is FavouritesInitial) {
          return Center(
            child: Text(
              "Loading favourites...",
              style: AppTextStyles.bady12.copyWith(color: AppColor.textPrimary),
            ),
          );
        } else if (state is FavouritesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavouritesError) {
          return Center(
            child: Text(
              state.message,
              style: AppTextStyles.h3bold18.copyWith(color: Colors.red),
            ),
          );
        } else if (state is FavouritesLoaded) {
          final favourites = state.favourites;

          if (favourites.isEmpty) {
            return Center(
              child: Text(
                "No favourites yet",
                style: AppTextStyles.h2bold24.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            );
          }

          return Expanded(
            child: ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final planet = favourites[index];
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width * 12 / 375,
                    vertical: height * 8 / 812,
                  ),
                  padding: EdgeInsets.all(width * 12 / 375),
                  decoration: BoxDecoration(
                    color: AppColor.surface.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(width * 16 / 375),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: width * 70 / 375,
                            height: height * 70 / 812,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(planet.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: width * 12 / 375),

                          Expanded(
                            child: Text(
                              planet.name,
                              style: AppTextStyles.h3bold18.copyWith(
                                color: AppColor.textPrimary,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_outlined,
                              color: AppColor.textPrimary,
                              size: width * 24 / 375,
                            ),
                            onPressed: () {
                              context
                                  .read<FavouritesCubit>()
                                  .removeFromFavourites(planet);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: height * 8 / 812),

                      Text(
                        planet.info,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bady12.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      SizedBox(height: height * 8 / 812),

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
                                color: AppColor.primaryColor,
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
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}