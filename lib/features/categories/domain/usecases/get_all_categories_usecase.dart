import 'package:flower_app/features/categories/data/repositories_impl/categories_repo_impl.dart';
import 'package:flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUseCase {
  final CategoriesRepoImpl _repo;

  GetAllCategoriesUseCase(this._repo);

  Future<List<CategoryEntity>> call() async {
    return await _repo.getAllCategories();
  }
}
