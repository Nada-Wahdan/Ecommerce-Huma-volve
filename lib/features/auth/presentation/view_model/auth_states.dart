import '../../domain/entities/auth_tokens_entity.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class LoginLoading extends AuthStates {}

class LoginSuccess extends AuthStates {
  final AuthTokensEntity tokens;

  LoginSuccess(this.tokens);
}

class LoginError extends AuthStates {
  final String errorMessage;

  LoginError(this.errorMessage);
}

class SignupLoading extends AuthStates {}

class SignupSuccess extends AuthStates {
  final UserEntity user;

  SignupSuccess(this.user);
}

class SignupError extends AuthStates {
  final String errorMessage;

  SignupError(this.errorMessage);
}
