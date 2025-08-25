part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class PlanetSelected extends HomeState {
  final String selectedPlanetName;

  const PlanetSelected(this.selectedPlanetName);

  @override
  List<Object?> get props => [selectedPlanetName];
}
