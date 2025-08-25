part of 'planet_cubit.dart';



abstract class PlanetState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlanetInitial extends PlanetState {}

class PlanetLoading extends PlanetState {}

class PlanetSuccess extends PlanetState {
  final PlanetModel planet;
  PlanetSuccess(this.planet);

  @override
  List<Object?> get props => [planet];
}

class PlanetError extends PlanetState {
  final String message;
  PlanetError(this.message);

  @override
  List<Object?> get props => [message];
}
