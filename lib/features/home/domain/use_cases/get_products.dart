import '../entities/product_entity.dart';
import '../repository/home_repository.dart';

class GetProducts {
  final HomeRepository repository;

  GetProducts(this.repository);

  Future<List<ProductEntity>> call({
    required int categoryId,
    required int offset,
    required int limit,
  }) {
    return repository.getProducts(
      categoryId: categoryId,
      offset: offset,
      limit: limit,
    );
  }
}
