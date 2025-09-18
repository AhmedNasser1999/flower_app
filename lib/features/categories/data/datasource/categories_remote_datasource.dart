import 'package:flower_app/features/categories/data/models/categories_response.dart';
import 'package:flower_app/features/categories/data/models/categoryResponse_byId_model.dart';

abstract class GetCategoriesRemoteDataSource {
  Future<CategoriesResponse> getAllCategories();
  Future<CategoryDetailsResponse> getCategoryById(String id);
}
