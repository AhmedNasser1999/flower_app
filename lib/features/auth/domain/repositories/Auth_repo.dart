import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';

import '../responses/auth_response.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:retrofit/retrofit.dart';

abstract class AuthRepo{

Future<LoginResponse> login(LoginRequest loginRequest);
  Future<AuthResponse<String>> forgetPassword(String email);
  Future<AuthResponse<String>> verifyCode(String code);
  Future<AuthResponse<String>> resetPassword(String email, String newPassword);
  Future<RegisterResponse> signUp(@Body() RegisterRequest registerRequest);
  Future<String> logout();
}