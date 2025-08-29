import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:flower_app/features/most_selling_products/domain/usecases/get_all_products_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionProductsUseCase {
  final GetAllProductsUseCase _getAllProductsUseCase;

  GetOccasionProductsUseCase(this._getAllProductsUseCase);

  Future<List<ProductsEntity>> call(String occasionId) async {
    return await _getAllProductsUseCase(occasionId: occasionId);
  }
}