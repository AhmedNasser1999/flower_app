import 'package:flower_app/core/contants/app_constants.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) =
      _AuthApiClient;

  @POST(AppConstants.signIn)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);
}
