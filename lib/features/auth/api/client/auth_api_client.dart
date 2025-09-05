
import 'package:flower_app/core/contants/app_constants.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/models/forget_password_models/forget_password_request.dart';
import '../../data/models/forget_password_models/reset_password_request_model.dart';
import '../../data/models/forget_password_models/verify_code_request_model.dart';



part 'auth_api_client.g.dart';

@injectable
@RestApi()
abstract class AuthApiClient {

  @factoryMethod
  factory AuthApiClient(Dio dio, {@Named('baseurl') String? baseUrl}) = _AuthApiClient;

  @POST(AppConstants.forgetPassword)
  Future<String> forgetPassword(@Body() ForgetPasswordRequestModel forgetPasswordRequestModel);

  @POST(AppConstants.verifyResetCode)
  Future<String> verifyResetCode(@Body() VerifyCodeRequestModel verifyResetCode);

  @PUT(AppConstants.restPassword)
  Future<String> resetPassword(@Body() ResetPasswordRequestModel resetPasswordRequestModel);

  @POST(AppConstants.signIn)
  Future<LoginResponse> login(@Body() LoginRequest loginRequest);




  @POST(AppConstants.signup)
  Future<RegisterResponse> signUp(@Body() RegisterRequest registerRequest);
}