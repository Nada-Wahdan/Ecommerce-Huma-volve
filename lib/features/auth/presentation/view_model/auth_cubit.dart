import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/login.dart';
import '../../domain/use_cases/signup.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final Login loginUseCase;
  final Signup signupUseCase;

  AuthCubit({required this.loginUseCase, required this.signupUseCase})
    : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final tokens = await loginUseCase(email: email, password: password);
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
      final user = await signupUseCase(
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
