import '../models/forget_password_models/forget_password_request.dart';
import '../models/forget_password_models/reset_password_request_model.dart';
import '../models/forget_password_models/verify_code_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/domain/responses/auth_response.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponse<String>> forgetPassword(
      ForgetPasswordRequestModel forgetPasswordRequestModel);
  Future<AuthResponse<String>> verifyResetPassword(
      VerifyCodeRequestModel verifyCodeRequestModel);
  Future<AuthResponse<String>> resetPassword(
      ResetPasswordRequestModel resetPasswordRequestModel);
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest);
  Future<RegisterResponse> signUp(RegisterRequest registerRequest);

  Future<String> logout();
}
