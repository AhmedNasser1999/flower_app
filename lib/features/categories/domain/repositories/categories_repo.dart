import 'package:flower_app/features/categories/data/models/categories_response.dart';

import '../../data/models/categoryResponse_byId_model.dart';

abstract class CategoriesRepo{
  Future<CategoriesResponse> getAllCategories();
  Future<CategoryDetailsResponse> getCategoryById(String id);

}