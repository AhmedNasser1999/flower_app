import 'package:flower_app/features/categories/data/models/categories_response.dart';
import 'package:flower_app/features/categories/data/models/categoryResponse_byId_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';
import '../../data/datasource/categories_remote_datasource.dart';

@LazySingleton(as: GetCategoriesRemoteDataSource)
class GetCategoriesRemoteDataSourceImpl
    implements GetCategoriesRemoteDataSource {
  final ApiClient _apiClient;

  GetCategoriesRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CategoriesResponse> getAllCategories() async {
    return await _apiClient.getAllCategories();
  }

  @override
  Future<CategoryDetailsResponse> getCategoryById(String id) async {
    return await _apiClient.getCategoryById(id);
  }
}
