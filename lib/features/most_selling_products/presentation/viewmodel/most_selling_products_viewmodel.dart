import 'package:flower_app/features/most_selling_products/domain/usecases/get_all_products_usecase.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_product_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MostSellingProductsViewmodel extends Cubit<MostSellingProductStates> {
  final GetAllProductsUseCase _allProductsUseCase;

  MostSellingProductsViewmodel(this._allProductsUseCase)
      : super(MostSellingInitialState());

  Future<void> getMostSellingProducts() async {
    emit(MostSellingLoadingState());

    try {
      final products = await _allProductsUseCase();
      emit(MostSellingSuccessState(products));
    } catch (e) {
      emit(MostSellingProductsErrorState(e.toString()));
    }
  }
}
