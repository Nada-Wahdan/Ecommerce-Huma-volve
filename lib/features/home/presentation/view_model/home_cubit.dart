import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/use_cases/get_categories.dart';
import '../../domain/use_cases/get_products.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final GetCategories getCategories;
  final GetProducts getProducts;
  List<CategoryEntity> _categories = [];
  int? _selectedCategoryId;

  HomeCubit({required this.getCategories, required this.getProducts})
    : super(HomeInitial());

  List<CategoryEntity> get categories => _categories;

  int? get selectedCategoryId => _selectedCategoryId;

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
    emit(ProductsLoading());

    try {
      final products = await getProducts(categoryId: categoryId);
      emit(ProductsSuccess(products));
    } catch (error) {
      emit(ProductsError(error.toString()));
    }
  }
}
