import '../entities/product_details_entity.dart';

abstract class ProductDetailsRepository {
  Future<ProductDetailsEntity> getProductDetails({required int productId});
}
