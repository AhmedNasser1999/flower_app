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

      // filter out invalid products (bad price/discount values)
      final validProducts = products.where((p) {
        try {
          _calculateDiscountPercentage(p.price, p.priceAfterDiscount);
          return true;
        } on ArgumentError {
          return false;
        }
      }).toList();

      emit(MostSellingSuccessState(validProducts));
    } catch (e) {
      emit(MostSellingProductsErrorState(e.toString()));
    }
  }

  int _calculateDiscountPercentage(int originalPrice, int discountedPrice) {
    if (originalPrice <= 0 || discountedPrice < 0 || discountedPrice > originalPrice) {
      throw ArgumentError("Invalid price values");
    }

    double discount = ((originalPrice - discountedPrice) / originalPrice) * 100;
    return discount.round();
  }
}
