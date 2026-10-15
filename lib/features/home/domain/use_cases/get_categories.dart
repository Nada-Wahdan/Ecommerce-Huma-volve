import '../entities/category_entity.dart';
import '../repository/home_repository.dart';

class GetCategories {
  final HomeRepository repository;

  GetCategories(this.repository);

  Future<List<CategoryEntity>> call() {
    return repository.getCategories();
  }
}
