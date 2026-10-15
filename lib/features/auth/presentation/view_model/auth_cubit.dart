import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repository/auth_repository.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final tokens = await authRepository.login(
        email: email,
        password: password,
      );
      emit(LoginSuccess(tokens));
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignupLoading());

    try {
      final user = await authRepository.signup(
        name: name,
        email: email,
        password: password,
      );
      emit(SignupSuccess(user));
    } catch (error) {
      emit(SignupError(error.toString()));
    }
  }
}
