import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';

import '../../domain/entities/product_entity.dart';
import 'category_model.dart';

class ProductModel {
  final int? id;
  final String? title;
  final String? slug;
  final int? price;
  final String? description;
  final CategoryModel? category;
  final List<String>? images;

  const ProductModel({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json[ApiKeys.id],
      title: json[ApiKeys.title],
      slug: json[ApiKeys.slug],
      price: json[ApiKeys.price],
      description: json[ApiKeys.description],
      category: json[ApiKeys.category] == null
          ? null
          : CategoryModel.fromJson(json[ApiKeys.category]),
      images: (json[ApiKeys.images] as List?)?.cast<String>(),
    );
  }

  ProductEntity toEntity() => ProductEntity(
    id: id,
    title: title,
    slug: slug,
    price: price,
    description: description,
    category: category?.toEntity(),
    images: images,
  );
}
