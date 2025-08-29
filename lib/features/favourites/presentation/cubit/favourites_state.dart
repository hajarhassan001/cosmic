part of 'favourites_cubit.dart';

abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object?> get props => [];
}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<PlanetModel> favourites;

  const FavouritesLoaded(this.favourites);

  @override
  List<Object?> get props => [favourites];
}

class FavouritesError extends FavouritesState {
  final String message;

  const FavouritesError(this.message);

  @override
  List<Object?> get props => [message];
}
