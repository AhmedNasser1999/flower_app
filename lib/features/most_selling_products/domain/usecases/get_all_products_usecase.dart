import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:injectable/injectable.dart';

import '../repositories/product_repo.dart';

@injectable
class GetAllProductsUseCase{
  final ProductRepo _productRepo;

  GetAllProductsUseCase(this._productRepo);

  Future<List<ProductsEntity>> call(
  {
    String? sort,
    String? search,
    String? category,
}
      ) async {
    return await _productRepo.getAllProducts(
      sort: sort,
      search: search,
      category: category,
    );
  }
}