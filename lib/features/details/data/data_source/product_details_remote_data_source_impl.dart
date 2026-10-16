import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/product_details_model.dart';
import 'product_details_remote_data_source.dart';

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final ApiClient apiClient;

  ProductDetailsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<ProductDetailsModel> getProductDetails({
    required int productId,
  }) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.productsEndpoint}/$productId',
    );

    return ProductDetailsModel.fromJson(
      Map<String, dynamic>.from(response.data as Map),
    );
  }
}
