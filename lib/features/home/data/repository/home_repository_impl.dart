import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repository/home_repository.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final models = await remoteDataSource.getCategories();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ProductEntity>> getProducts({
    required int categoryId,
    required int offset,
    required int limit,
  }) async {
    final models = await remoteDataSource.getProducts(
      categoryId: categoryId,
      offset: offset,
      limit: limit,
    );
    return models.map((model) => model.toEntity()).toList();
  }
}
