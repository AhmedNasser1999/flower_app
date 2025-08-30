import 'package:flower_app/features/categories/domain/entities/category_entity.dart';

import '../../data/models/categoryResponse_byId_model.dart';

abstract class CategoriesRepo {
  Future<List<CategoryEntity>> getAllCategories();
  Future<CategoryDetailsResponse> getCategoryById(String id);
}
