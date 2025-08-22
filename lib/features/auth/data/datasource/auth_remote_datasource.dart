
import '../model/forget_password_request.dart';
import '../model/reset_password_request_model.dart';
import '../model/verify_code_request_model.dart';

abstract class AuthRemoteDatasource {
  Future<String> forgetPassword(ForgetPasswordRequestModel forgetPasswordRequestModel);
  Future<String> verifyResetPassword(VerifyCodeRequestModel verifyCodeRequestModel);
  Future<String> resetPassword(ResetPasswordRequestModel resetPasswordRequestModel);
}