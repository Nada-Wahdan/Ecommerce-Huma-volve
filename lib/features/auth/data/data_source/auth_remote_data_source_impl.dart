import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';

import '../models/login_model.dart';
import '../models/signup_req_model.dart';
import '../models/signup_res_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndpoint,
      data: {ApiKeys.email: email, ApiKeys.password: password},
    );

    return LoginModel.fromJson(response.data);
  }

  @override
  Future<SignupResponseModel> signup(SignupRequestModel request) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signupEndpoint,
      data: {
        ApiKeys.name: request.name,
        ApiKeys.email: request.email,
        ApiKeys.password: request.password,
        ApiKeys.avatar: 'https://api.lorem.space/image/face?w=640&h=480',
      },
    );

    return SignupResponseModel.fromJson(response.data);
  }
}
