import 'package:flower_app/features/categories/api/datasource_impl/catogries_remote_datasource_impl.dart';
import 'package:flower_app/features/categories/data/models/categoryResponse_byId_model.dart';
import 'package:flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/categories_repo.dart';
@LazySingleton()
class CategoriesRepoImpl implements CategoriesRepo {
  final GetCategoriesRemoteDataSourceImpl _categoriesRemoteDataSource;

  CategoriesRepoImpl(this._categoriesRemoteDataSource);

  @override
  @override
  Future<CategoryDetailsResponse> getCategoryById(String id) async {
    return await _categoriesRemoteDataSource.getCategoryById(id);
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    final categorys = await _categoriesRemoteDataSource.getAllCategories();
    return categorys.categories!;
  }
}
