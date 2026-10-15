import 'category_entity.dart';

class ProductEntity {
  final int? id;
  final String? title;
  final String? slug;
  final int? price;
  final String? description;
  final CategoryEntity? category;
  final List<String>? images;

  const ProductEntity({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.description,
    this.category,
    this.images,
  });
}
