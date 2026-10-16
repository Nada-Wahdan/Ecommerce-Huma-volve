import '../../../../core/constants/api_endpoints.dart';
import '../../domain/entities/product_details_entity.dart';

class ProductDetailsModel {
  final int? id;
  final String? title;
  final int? price;
  final String? description;
  final List<String>? images;

  const ProductDetailsModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.images,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json[ApiKeys.id] as int?,
      title: json[ApiKeys.title] as String?,
      price: json[ApiKeys.price] as int?,
      description: json[ApiKeys.description] as String?,
      images: (json[ApiKeys.images] as List?)
          ?.map((image) => image.toString())
          .toList(),
    );
  }

  ProductDetailsEntity toEntity() => ProductDetailsEntity(
    id: id,
    title: title,
    price: price,
    description: description,
    images: images,
  );
}
