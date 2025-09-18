
import 'package:flower_app/features/categories/data/models/categories_response.dart';
import 'package:flower_app/features/categories/data/models/categoryResponse_byId_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/categories_repo.dart';
import '../datasource/categories_remote_datasource.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl implements CategoriesRepo{

  final GetCategoriesRemoteDataSource _categoriesRemoteDataSource;

  CategoriesRepoImpl(this._categoriesRemoteDataSource);

  @override
  Future<CategoriesResponse> getAllCategories() async{
   return await _categoriesRemoteDataSource.getAllCategories();
  }

  @override
  Future<CategoryDetailsResponse> getCategoryById(String id) async{
    return await _categoriesRemoteDataSource.getCategoryById(id);

  }

}