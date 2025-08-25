import 'package:bloc/bloc.dart';
import 'package:cosmic/features/home/data/remote/datadase_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FirebaseHomeService firebaseHomeService;

  HomeCubit(this.firebaseHomeService) : super(HomeInitial());

  String? selectedPlanetName;

  void selectPlanet(String name) {
    selectedPlanetName = name;
    emit(PlanetSelected(name));
  }
}
