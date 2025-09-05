import 'package:injectable/injectable.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';

import 'package:flower_app/core/errors/failure.dart';

import 'package:flower_app/features/auth/domain/responses/auth_response.dart';

import '../models/forget_password_models/forget_password_request.dart';
import '../models/forget_password_models/reset_password_request_model.dart';
import '../models/forget_password_models/verify_code_request_model.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepoImpl(this._authRemoteDatasource);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      return await _authRemoteDatasource.login(loginRequest);
    } on DioException catch (e) {
      final message = _extractApiMessage(e);
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  String _extractApiMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      return data['error'] ??
          data['message'] ??
          ServerFailure.fromDio(e).errorMessage;
    }
    if (data is String) {
      try {
        final decoded = json.decode(data);
        if (decoded is Map) {
          return decoded['error'] ??
              decoded['message'] ??
              ServerFailure.fromDio(e).errorMessage;
        }
      } catch (_) {}
    }
    return ServerFailure.fromDio(e).errorMessage;
  }

  @override
  Future<AuthResponse<String>> forgetPassword(String email) async {
    final model = ForgetPasswordRequestModel(email: email);
    return await _authRemoteDatasource.forgetPassword(model);
  }

  @override
  Future<AuthResponse<String>> verifyCode(String code) async {
    final model = VerifyCodeRequestModel(resetCode: code);
    return await _authRemoteDatasource.verifyResetPassword(model);
    try {
      final model = VerifyCodeRequestModel(resetCode: code);
      final result = await _authRemoteDatasource.verifyResetPassword(model);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> resetPassword(String email, String newPassword) async {
    final model = ResetPasswordRequestModel(email: email, newPassword: newPassword);
    return await _authRemoteDatasource.resetPassword(model);
  Future<AuthResponse<String>> resetPassword(
      String email, String newPassword) async {
    try {
      final model =
          ResetPasswordRequestModel(email: email, newPassword: newPassword);
      final result = await _authRemoteDatasource.resetPassword(model);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<LoginResponse>> login(LoginRequest loginRequest) async {
    return await _authRemoteDatasource.login(loginRequest);
  Future<RegisterResponse> signUp(RegisterRequest registerRequest) {
    return _authRemoteDatasource.signUp(registerRequest);
  }

  @override
  Future<String> logout() {
    return _authRemoteDatasource.logout();
  }
}
