import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';

abstract class ProductRepo {
  Future<List<ProductsEntity>> getAllProducts();
}
