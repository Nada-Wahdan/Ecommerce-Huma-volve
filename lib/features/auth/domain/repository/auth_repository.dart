import '../entities/auth_tokens_entity.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthTokensEntity> login({
    required String email,
    required String password,
  });

  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
  });
}
