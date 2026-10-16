import '../entities/product_details_entity.dart';
import '../repository/product_details_repository.dart';

class GetProductDetails {
  final ProductDetailsRepository repository;

  GetProductDetails(this.repository);

  Future<ProductDetailsEntity> call({required int productId}) {
    return repository.getProductDetails(productId: productId);
  }
}
