import '../models/products_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<Products>> getAllProduct({
    String? sort,
    String? search,
    String? category,
  });
}
