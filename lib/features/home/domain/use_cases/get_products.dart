import '../entities/product_entity.dart';
import '../repository/home_repository.dart';

class GetProducts {
  final HomeRepository repository;

  GetProducts(this.repository);

  Future<List<ProductEntity>> call({required int categoryId}) {
    return repository.getProducts(categoryId: categoryId);
  }
}
