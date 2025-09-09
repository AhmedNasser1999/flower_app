import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../data/models/products_reponse_model.dart';

part 'product_api_client.g.dart';

@injectable
@RestApi()
abstract class ProductApiClient {
  @factoryMethod
  factory ProductApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) =>
      _ProductApiClient(dio, baseUrl: baseUrl);

  @GET('/products')
  Future<ProductsResponseModel> getAllProducts(
      @Query('sort') String? sort, @Query('search') String? search, @Query('category') String? category);
}
