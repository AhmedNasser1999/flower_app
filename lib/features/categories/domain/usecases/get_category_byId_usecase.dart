import 'package:injectable/injectable.dart';
import '../../data/models/categoryResponse_byId_model.dart';
import '../repositories/categories_repo.dart';

@lazySingleton
class GetCategoryByIdUseCase {
  final CategoriesRepo _repo;

  GetCategoryByIdUseCase(this._repo);

  Future<CategoryDetailsResponse> call(String id) async {
    return await _repo.getCategoryById(id);
  }
}
