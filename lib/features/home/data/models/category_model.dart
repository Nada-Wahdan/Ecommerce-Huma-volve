import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';

import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final int? id;
  final String? name;

  const CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json[ApiKeys.id], name: json[ApiKeys.name]);
  }

  CategoryEntity toEntity() => CategoryEntity(id: id, name: name);
}
