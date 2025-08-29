import 'package:flower_app/features/most_selling_products/domain/usecases/get_all_products_usecase.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/products_entity.dart';

@injectable
class MostSellingProductsViewmodel extends Cubit<MostSellingProductStates> {
  final GetAllProductsUseCase _allProductsUseCase;

  List<ProductsEntity> _allProducts = [];

  MostSellingProductsViewmodel(this._allProductsUseCase)
      : super(MostSellingInitialState());

  Future<void> getMostSellingProducts() async {
    emit(MostSellingLoadingState());
    try {
      final products = await _allProductsUseCase();
      _allProducts = products;
      emit(MostSellingSuccessState(products));
    } catch (e) {
      emit(MostSellingProductsErrorState(e.toString()));
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      emit(MostSellingSuccessState(_allProducts));
    } else {
      final filtered = _allProducts
          .where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(MostSellingSuccessState(filtered));
    }
  }

  void filterByCategory(String? categoryId) {
    if (categoryId == null || categoryId.isEmpty) {
      emit(MostSellingSuccessState(_allProducts));
    } else {
      final filtered = _allProducts
          .where((product) => product.category == categoryId)
          .toList();
      emit(MostSellingSuccessState(filtered));
    }
  }
  void filterByCategoryAndSearch(String categoryId, String query) {
    final filtered = _allProducts
        .where((p) => p.category == categoryId && p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    emit(MostSellingSuccessState(filtered));
  }


}
