import 'package:flower_app/features/categories/domain/entities/category_entity.dart';

import '../../data/models/categoryResponse_byId_model.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class GetAllCategoriesLoading extends CategoriesState {}

class GetAllCategoriesSuccess extends CategoriesState {
 final List<CategoryEntity> categories;
  GetAllCategoriesSuccess(this.categories);
}

class GetAllCategoriesError extends CategoriesState {
  final String message;
  GetAllCategoriesError(this.message);
}

class GetCategoryDetailsLoading extends CategoriesState {}

class GetCategoryDetailsSuccess extends CategoriesState {
  final CategoryDetailsResponse category;
  GetCategoryDetailsSuccess(this.category);
}

class GetCategoryDetailsError extends CategoriesState {
  final String message;
  GetCategoryDetailsError(this.message);
}
