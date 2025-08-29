import '../models/products_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<Products>> getAllProduct({
    String? occasionId,
    int? page,
    int? limit,
});
}