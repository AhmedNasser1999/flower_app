import 'package:flower_app/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:flower_app/features/most_selling_products/domain/usecases/get_all_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../categories/domain/entity/category_entity.dart';
import '../../../occasion/domain/usecases/get_occasions_use_case.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetAllProductsUseCase _allProductsUseCase;
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetOccasionsUseCase getAllOccasionsUseCase;

  HomeCubit(this._allProductsUseCase, this.getAllCategoriesUseCase,
      this.getAllOccasionsUseCase)
      : super(HomeInitial());

  Future<void> getMostSellingProducts() async {
    emit(HomeLoadingState());
    try {
      final products = await _allProductsUseCase();
      emit(HomeSuccessState(products: products));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  Future<void> getAllCategories() async {
    emit(HomeLoadingState());
    try {
      final response = await getAllCategoriesUseCase();
      emit(HomeSuccessState(categories: response.categories ?? []));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

    Future<void> getAllOccasions() async {
      emit(HomeLoadingState());
      try {
        final occasions = await getAllOccasionsUseCase();
        emit(HomeSuccessState(occasions: occasions));
      } catch (e) {
        emit(HomeErrorState(e.toString()));
      }
    }

}
