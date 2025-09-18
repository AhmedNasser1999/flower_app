import 'package:flower_app/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:flower_app/features/most_selling_products/domain/usecases/get_all_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../occasion/domain/usecases/get_occasions_use_case.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetAllProductsUseCase _allProductsUseCase;
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetOccasionsUseCase getAllOccasionsUseCase;

  HomeCubit(this._allProductsUseCase, this.getAllCategoriesUseCase,
      this.getAllOccasionsUseCase)
      : super(HomeState());

  // Initialize all data
  Future<void> initializeHomeData() async {
    await Future.wait([
      getMostSellingProducts(),
      getAllCategories(),
      getAllOccasions(),
    ]);
  }

  Future<void> getMostSellingProducts() async {
    emit(state.copyWith(isProductsLoadingArg: true, productsErrorArg: null));
    try {
      final products = await _allProductsUseCase();
      emit(state.copyWith(
        isProductsLoadingArg: false,
        productsListArg: products,
        productsErrorArg: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProductsLoadingArg: false,
        productsErrorArg: e.toString(),
      ));
    }
  }

  Future<void> getAllCategories() async {
    emit(state.copyWith(isCategoriesLoadingArg: true, categoriesErrorArg: null));
    try {
      final response = await getAllCategoriesUseCase();
      final categories = response.categories ?? [];
      emit(state.copyWith(
        isCategoriesLoadingArg: false,
        categoriesListArg: categories,
        categoriesErrorArg: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isCategoriesLoadingArg: false,
        categoriesErrorArg: e.toString(),
      ));
    }
  }

  Future<void> getAllOccasions() async {
    emit(state.copyWith(isOccasionsLoadingArg: true, occasionsErrorArg: null));
    try {
      final occasions = await getAllOccasionsUseCase();
      emit(state.copyWith(
        isOccasionsLoadingArg: false,
        occasionsListArg: occasions,
        occasionsErrorArg: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isOccasionsLoadingArg: false,
        occasionsErrorArg: e.toString(),
      ));
    }
  }

  // Refresh individual sections
  Future<void> refreshCategories() async {
    await getAllCategories();
  }

  Future<void> refreshProducts() async {
    await getMostSellingProducts();
  }

  Future<void> refreshOccasions() async {
    await getAllOccasions();
  }
}
