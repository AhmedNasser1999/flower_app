
import 'package:injectable/injectable.dart';

import '../../data/models/categories_response.dart';
import '../repositories/categories_repo.dart';

@lazySingleton
class GetAllCategoriesUseCase{

  final CategoriesRepo _repo;

  GetAllCategoriesUseCase(this._repo);

  Future<CategoriesResponse> call()async{
    return await _repo.getAllCategories();
  }
}