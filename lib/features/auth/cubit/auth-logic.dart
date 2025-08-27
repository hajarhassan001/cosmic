import 'package:bloc/bloc.dart';
import 'package:cosmic/features/auth/cubit/auth_state.dart';
import 'package:cosmic/features/auth/data_base/firebase_functions.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseFunctions _firebaseFunctions;
  AuthCubit(this._firebaseFunctions) : super(AuthInitial());

  Future<void> signUp(String name, String email, String password) async {
    if (!email.contains('@')) {
      emit(AuthFailure("Email must contain '@'"));
      return;
    }
    if (password.length < 8) {
      emit(AuthFailure("Password must be at least 8 characters"));
      return;
    }
      emit(AuthLoading());
    try {
      final user = await _firebaseFunctions.signUp(name, email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    if (!email.contains('@')) {
      emit(AuthFailure("Email must contain '@'"));
      return;
    }
    if (password.length < 8) {
      emit(AuthFailure("Password must be at least 8 characters"));
      return;
    }
    emit(AuthLoading());
    try {
      final user = await _firebaseFunctions.login(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logOut() async {
  await _firebaseFunctions.logOut();
  emit(AuthInitial());
} 
}
