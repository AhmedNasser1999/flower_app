import 'package:flower_app/features/auth/api/client/auth_api_client.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/forget_password_models/forget_password_request.dart';
import '../../data/models/forget_password_models/reset_password_request_model.dart';
import '../../data/models/forget_password_models/verify_code_request_model.dart';

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {

  final AuthApiClient _authApiClient;

  AuthRemoteDatasourceImpl(this._authApiClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _authApiClient.login(loginRequest);

  }


  @override
  Future<String> forgetPassword(ForgetPasswordRequestModel forgetPasswordRequestModel) async{
    return await _authApiClient.forgetPassword(forgetPasswordRequestModel);
  }

  @override
  Future<String> resetPassword(ResetPasswordRequestModel resetPasswordRequestModel) async{
    return await _authApiClient.resetPassword(resetPasswordRequestModel);
  }

  @override
  Future<String> verifyResetPassword(VerifyCodeRequestModel verifyCodeRequestModel) async{
    return await _authApiClient.verifyResetCode(verifyCodeRequestModel);
  }

}