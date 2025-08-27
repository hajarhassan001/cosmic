import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());


  void selectPlanet(String name) {
    emit(state.copyWith(selectedName: name));
  }

  void changeIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
  void clearSelectedPlanet() {
  emit(state.copyWith(selectedName: null));
}

}
