  import 'package:flower_app/features/most_selling_products/api/client/product_api_client.dart';
import 'package:flower_app/features/most_selling_products/data/models/products_model.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasource/product_remote_datasource.dart';

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource{

  final ProductApiClient _productApiClient;

  ProductRemoteDataSourceImpl(this._productApiClient);

  @override
  Future<List<Products>> getAllProduct() async{
    try {
      final response = await _productApiClient.getAllProducts();
      return response.products;
    } catch(e){
      throw Exception("failed to fetch products: $e");
    }
  }
}