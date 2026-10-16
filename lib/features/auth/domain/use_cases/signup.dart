import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class Signup {
  final AuthRepository repository;

  Signup(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.signup(name: name, email: email, password: password);
  }
}
