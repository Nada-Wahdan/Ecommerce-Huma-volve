import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';

import '../../domain/entities/user_entity.dart';

class SignupResponseModel {
  final int? id;
  final String? email;
  final String? name;
  final String? role;
  final String? avatar;

  const SignupResponseModel({
    this.id,
    this.email,
    this.name,
    this.role,
    this.avatar,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      id: json[ApiKeys.id],
      email: json[ApiKeys.email],
      name: json[ApiKeys.name],
      role: json[ApiKeys.role],
      avatar: json[ApiKeys.avatar],
    );
  }

  UserEntity toEntity() =>
      UserEntity(id: id, email: email, name: name, role: role, avatar: avatar);
}
