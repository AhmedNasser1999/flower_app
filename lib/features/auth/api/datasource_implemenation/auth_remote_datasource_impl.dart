import 'package:flower_app/features/auth/api/client/auth_api_client.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:injectable/injectable.dart';
import '../../data/model/forget_password_request.dart';
import '../../data/model/reset_password_request_model.dart';
import '../../data/model/verify_code_request_model.dart';

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {

  final AuthApiClient _authApiClient;

  AuthRemoteDatasourceImpl(this._authApiClient);

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