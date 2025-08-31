import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/contants/app_constants.dart';
import '../../data/models/profile_response.dart';
part 'profile_api_client.g.dart';

@injectable
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) =>
      _ProfileApiClient(dio, baseUrl: baseUrl);

  @GET(AppConstants.profile)
  @Extra({'auth': true})
  Future<ProfileResponse> getProfile();
}
