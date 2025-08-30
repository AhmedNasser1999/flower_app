import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:flower_app/features/occasion/domain/entity/occasion_entity.dart';
import 'package:flower_app/features/categories/data/models/category_model.dart'; // 👈 استبدل الـ Entity بالـ Model

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<Categories> categories;

  final List<ProductsEntity> products;

  final List<OccasionEntity> occasions;

  HomeSuccessState({
    this.categories = const [],
    this.products = const [],
    this.occasions = const [],
  });
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
