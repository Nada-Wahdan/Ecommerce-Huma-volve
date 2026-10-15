import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import 'home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiEndpoints.categoriesEndpoint);
    final List<dynamic> jsonData = response.data;
    return jsonData.map((json) => CategoryModel.fromJson(json)).toList();
  }

  @override
  Future<List<ProductModel>> getProducts({required int categoryId}) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.categoriesEndpoint}/$categoryId/${ApiEndpoints.productsEndpoint}',
    );
    final List<dynamic> jsonData = response.data;
    return jsonData.map((json) => ProductModel.fromJson(json)).toList();
  }
}
