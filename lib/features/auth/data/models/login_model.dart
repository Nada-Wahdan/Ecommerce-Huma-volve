import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';

import '../../domain/entities/auth_tokens_entity.dart';

class LoginModel {
  final String? accessToken;
  final String? refreshToken;

  const LoginModel({this.accessToken, this.refreshToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json[ApiKeys.accessToken],
      refreshToken: json[ApiKeys.refreshToken],
    );
  }

  AuthTokensEntity toEntity() =>
      AuthTokensEntity(accessToken: accessToken, refreshToken: refreshToken);
}
