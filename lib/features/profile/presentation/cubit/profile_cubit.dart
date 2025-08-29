import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/remote/profile_firebase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService _service;

  ProfileCubit(this._service) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final name = await _service.loadName();
      emit(ProfileLoaded(name));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateName(String newName) async {
    try {
      await _service.updateName(newName);
      emit(ProfileLoaded(newName));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
