import 'package:flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<CategoryEntity> categories;

  final List<ProductsEntity> products;

  HomeSuccessState({
    this.categories = const [],
    this.products = const [],
  });
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
