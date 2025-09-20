import 'package:flower_app/features/most_selling_products/api/client/product_api_client.dart';
import 'package:flower_app/features/most_selling_products/data/models/products_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';
import '../../data/datasource/product_remote_datasource.dart';

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient productApiClient;

  ProductRemoteDataSourceImpl(this.productApiClient);

  @override
  Future<List<Products>> getAllProduct({
    String? sort,
    String? search,
    String? category,
  }) async {
    final response = await productApiClient.getAllProducts(
      sort,
      search,
      category,
    );
    return response.products;
  }
}
