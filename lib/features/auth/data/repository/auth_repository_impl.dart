import '../../domain/entities/auth_tokens_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';
import '../models/signup_req_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthTokensEntity> login({
    required String email,
    required String password,
  }) async {
    final model = await remoteDataSource.login(
      email: email,
      password: password,
    );
    return model.toEntity();
  }

  @override
  Future<UserEntity> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final model = await remoteDataSource.signup(
      SignupRequestModel(name: name, email: email, password: password),
    );
    return model.toEntity();
  }
}
