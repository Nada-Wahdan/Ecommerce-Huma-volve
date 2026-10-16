import '../../domain/entities/product_details_entity.dart';
import '../../domain/repository/product_details_repository.dart';
import '../data_source/product_details_remote_data_source.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource remoteDataSource;

  ProductDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProductDetailsEntity> getProductDetails({
    required int productId,
  }) async {
    final model = await remoteDataSource.getProductDetails(
      productId: productId,
    );
    return model.toEntity();
  }
}
