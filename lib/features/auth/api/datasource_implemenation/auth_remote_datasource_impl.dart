import 'package:dio/dio.dart';
import 'package:flower_app/features/auth/api/client/auth_api_client.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/domain/responses/auth_response.dart';
import 'package:flower_app/core/errors/failure.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';
import '../../data/models/forget_password_models/forget_password_request.dart';
import '../../data/models/forget_password_models/reset_password_request_model.dart';
import '../../data/models/forget_password_models/verify_code_request_model.dart';

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {

  final AuthApiClient _authApiClient;

  AuthRemoteDatasourceImpl(this._authApiClient);

  String _extractApiMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      return data['error'] ?? data['message'] ?? ServerFailure.fromDio(e).errorMessage;
    }
    if (data is String) {
      try {
        final decoded = json.decode(data);
        if (decoded is Map) {
          return decoded['error'] ?? decoded['message'] ?? ServerFailure.fromDio(e).errorMessage;
        }
      } catch (_) {}
    }
    return ServerFailure.fromDio(e).errorMessage;
  }

  @override
  Future<AuthResponse<String>> forgetPassword(ForgetPasswordRequestModel forgetPasswordRequestModel) async {
    try {
      final result = await _authApiClient.forgetPassword(forgetPasswordRequestModel);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> resetPassword(ResetPasswordRequestModel resetPasswordRequestModel) async {
    try {
      final result = await _authApiClient.resetPassword(resetPasswordRequestModel);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> verifyResetPassword(VerifyCodeRequestModel verifyCodeRequestModel) async {
    try {
      final result = await _authApiClient.verifyResetCode(verifyCodeRequestModel);
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
    try {
      final result = await _authApiClient.login(loginRequest);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }
  @override
  Future<RegisterResponse> signUp(RegisterRequest registerRequest) {
    return _authApiClient.signUp(registerRequest);
  }
}