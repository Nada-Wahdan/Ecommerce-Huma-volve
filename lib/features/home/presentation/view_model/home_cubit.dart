import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/get_categories.dart';
import '../../domain/use_cases/get_products.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategories getCategories;
  final GetProducts getProducts;
  List<CategoryEntity> _categories = [];
  List<ProductEntity> _products = [];
  int? _selectedCategoryId;
  int _productsOffset = 0;
  static const int _productsPageSize = 10;
  bool _isLoadingMore = false;
  bool _hasMoreProducts = true;

  HomeCubit({required this.getCategories, required this.getProducts})
    : super(HomeInitial());

  List<CategoryEntity> get categories => _categories;

  int? get selectedCategoryId => _selectedCategoryId;

  bool get hasMoreProducts => _hasMoreProducts;

  Future<void> loadHomeData() async {
    emit(CategoriesLoading());

    try {
      _categories = await getCategories();
      emit(CategoriesSuccess(_categories));

      if (_categories.isEmpty) {
        emit(ProductsSuccess(const []));
        return;
      }

      final categoryId = _categories.first.id;
      if (categoryId == null) {
        emit(ProductsSuccess(const []));
        return;
      }

      await loadProducts(categoryId: categoryId);
    } catch (error) {
      emit(CategoriesError(error.toString()));
    }
  }

  Future<void> loadProducts({required int categoryId}) async {
    _selectedCategoryId = categoryId;
    _products = [];
    _productsOffset = 0;
    _hasMoreProducts = true;
    emit(ProductsLoading());

    try {
      final products = await getProducts(
        categoryId: categoryId,
        offset: _productsOffset,
        limit: _productsPageSize,
      );
      _products = products;
      _productsOffset += products.length;
      _hasMoreProducts = products.length == _productsPageSize;
      emit(ProductsSuccess(List.unmodifiable(_products)));
    } catch (error) {
      emit(ProductsError(error.toString()));
    }
  }

  Future<void> loadMoreProducts() async {
    if (_isLoadingMore || !_hasMoreProducts || _selectedCategoryId == null) {
      return;
    }

    _isLoadingMore = true;
    emit(ProductsLoadingMore(List.unmodifiable(_products)));

    try {
      final products = await getProducts(
        categoryId: _selectedCategoryId!,
        offset: _productsOffset,
        limit: _productsPageSize,
      );
      _products.addAll(products);
      _productsOffset += products.length;
      _hasMoreProducts = products.length == _productsPageSize;
      emit(ProductsSuccess(List.unmodifiable(_products)));
    } catch (error) {
      emit(ProductsSuccess(List.unmodifiable(_products)));
    } finally {
      _isLoadingMore = false;
    }
  }
}
