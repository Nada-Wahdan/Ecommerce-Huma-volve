import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_product_details.dart';
import 'product_details_states.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetails getProductDetails;

  ProductDetailsCubit({required this.getProductDetails})
    : super(ProductDetailsInitial());

  Future<void> loadProductDetails({required int productId}) async {
    emit(ProductDetailsLoading());

    try {
      final product = await getProductDetails(productId: productId);
      emit(ProductDetailsSuccess(product));
    } catch (error) {
      emit(ProductDetailsError(error.toString()));
    }
  }
}
