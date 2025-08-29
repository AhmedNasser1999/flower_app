import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';

abstract class OccasionState {}

class OccasionInitial extends OccasionState {}

class OccasionLoading extends OccasionState {}

class OccasionLoaded extends OccasionState {
  final List<ProductsEntity> products;

  OccasionLoaded(this.products);
}

class OccasionError extends OccasionState {
  final String message;

  OccasionError(this.message);
}