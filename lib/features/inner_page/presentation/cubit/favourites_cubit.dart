
import 'package:cosmic/features/home/data/models/planet_model.dart';
import 'package:cosmic/features/home/data/remote/database_fire.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cosmic/features/home/data/remote/datadase_firestore.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  final FavouritesService _service;
  final FirebaseHomeService _getPlanet;
  final String userId;

  FavouritesCubit(this._service, this.userId, this._getPlanet)
    : super(FavouritesInitial()) {
    loadFavourites();
  }

  Future<void> loadFavourites() async {
    emit(FavouritesLoading());
    try {
      final favNames = await _service.loadFavourites(userId);

      final favPlanets = <PlanetModel>[];
      for (var name in favNames) {
        final planet = await _getPlanet.getPlanetByName(name);
        favPlanets.add(planet);
      }

      //       favPlanets = [
      //   PlanetModel("Mars", image: "...", info: "..."),
      //   PlanetModel("Venus", image: "...", info: "..."),
      //   PlanetModel("Earth", image: "...", info: "...")
      // ];

      emit(FavouritesLoaded(favPlanets));
    } catch (e) {
      emit(FavouritesError(e.toString()));
    }
  }

  bool isFavourite(PlanetModel planet) {
    if (state is FavouritesLoaded) {
      final favs = (state as FavouritesLoaded).favourites;
      return favs.any((p) => p.name == planet.name);
    }
    return false;
  }

  Future<void> toggleFavourite(PlanetModel planet) async {
    if (state is FavouritesLoaded) {
      if (isFavourite(planet)) {
        await removeFromFavourites(planet);
      } else {
        await addToFavourites(planet);
      }
    }
  }

  Future<void> addToFavourites(PlanetModel planet) async {
    if (state is FavouritesLoaded) {
      final current = (state as FavouritesLoaded).favourites;
      await _service.addToFavourites(userId, planet.name);
      emit(FavouritesLoaded([...current, planet]));
    }
  }

  Future<void> removeFromFavourites(PlanetModel planet) async {
    if (state is FavouritesLoaded) {
      final current = (state as FavouritesLoaded).favourites;
      await _service.removeFromFavourites(userId, planet.name);
      emit(
        FavouritesLoaded(current.where((p) => p.name != planet.name).toList()),
      );
    }
  }
}