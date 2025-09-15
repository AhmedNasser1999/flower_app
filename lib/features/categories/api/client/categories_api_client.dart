import 'package:dio/dio.dart';
import 'package:flower_app/core/contants/app_constants.dart';
import 'package:flower_app/features/categories/data/models/categories_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../data/models/categoryResponse_byId_model.dart';

part 'categories_api_client.g.dart';

@injectable
@RestApi()
abstract class CategoryApiClient {
  @factoryMethod
  factory CategoryApiClient(
    Dio dio, {
    @Named('baseurl') String? baseUrl,
  }) = _CategoryApiClient;

  @GET(AppConstants.categories)
  Future<CategoriesResponse> getAllCategories();

  @GET("${AppConstants.categories}/{id}")
  Future<CategoryDetailsResponse> getCategoryById(@Path("id") String id);
}
