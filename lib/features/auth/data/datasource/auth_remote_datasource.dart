import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';


import '../models/forget_password_models/forget_password_request.dart';
import '../models/forget_password_models/reset_password_request_model.dart';
import '../models/forget_password_models/verify_code_request_model.dart';

import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';

abstract class AuthRemoteDatasource {
  Future<String> forgetPassword(ForgetPasswordRequestModel forgetPasswordRequestModel);
  Future<String> verifyResetPassword(VerifyCodeRequestModel verifyCodeRequestModel);
  Future<String> resetPassword(ResetPasswordRequestModel resetPasswordRequestModel);

  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<RegisterResponse> signUp(RegisterRequest registerRequest);
}