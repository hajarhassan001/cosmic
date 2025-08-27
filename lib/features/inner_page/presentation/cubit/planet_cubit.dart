import 'package:bloc/bloc.dart';
import 'package:cosmic/features/home/data/models/planet_model.dart';
import 'package:cosmic/features/home/data/remote/datadase_firestore.dart';
import 'package:equatable/equatable.dart';

part 'planet_state.dart';

class PlanetCubit extends Cubit<PlanetState> {
  final FirebaseHomeService firebaseHomeService;

  PlanetCubit(this.firebaseHomeService) : super(PlanetInitial());

  Future<void> getPlanetByName(String name) async {
    try {
      emit(PlanetLoading());

      final planet = await firebaseHomeService.getPlanetByName(name);

      emit(PlanetSuccess(planet));
    } catch (e) {
      emit(PlanetError(e.toString()));
    }
  }

  Future<void> getPlanetOfTheDay() async {
    emit(PlanetLoading());
    try {
      final planet = await firebaseHomeService.getPlanetOfTheDay();
      emit(PlanetSuccess(planet));
    } catch (e) {
      emit(PlanetError(e.toString()));
    }
  }
}
