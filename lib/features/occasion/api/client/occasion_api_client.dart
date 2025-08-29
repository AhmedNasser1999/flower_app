import 'package:flower_app/features/occasion/data/models/occasion_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'occasion_api_client.g.dart';

@injectable
@RestApi()
abstract class OccasionApiClient {
  @factoryMethod
  factory OccasionApiClient(Dio dio, {@Named("baseurl") String? baseUrl}) =>
      _OccasionApiClient(dio, baseUrl: baseUrl);

  @GET("/occasions")
  Future<OccasionsResponse> getOccasions({
    @Query("page") int? page,
    @Query("limit") int? limit,
  });
}