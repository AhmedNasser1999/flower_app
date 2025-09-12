import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';

abstract class MostSellingProductStates {}

class MostSellingInitialState extends MostSellingProductStates {}
class MostSellingLoadingState extends MostSellingProductStates {}
class MostSellingSuccessState extends MostSellingProductStates {
  final List<ProductsEntity> products;

  MostSellingSuccessState(this.products);
}
class MostSellingProductsErrorState extends MostSellingProductStates {
  final String message;

  MostSellingProductsErrorState(this.message);
}