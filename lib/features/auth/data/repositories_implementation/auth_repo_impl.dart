import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:flower_app/features/auth/data/model/forget_password_request.dart';
import 'package:flower_app/features/auth/data/model/verify_code_request_model.dart';
import 'package:flower_app/features/auth/data/model/reset_password_request_model.dart';
import 'package:flower_app/core/errors/failure.dart';
import 'package:flower_app/features/auth/domain/responses/auth_response.dart';
import 'dart:convert';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepoImpl(this._authRemoteDatasource);

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
  Future<AuthResponse<String>> forgetPassword(String email) async {
    try {
      final model = ForgetPasswordRequestModel(email: email);
      final result = await _authRemoteDatasource.forgetPassword(model);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> verifyCode(String code) async {
    try {
      final model= VerifyCodeRequestModel(resetCode: code);
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
    try {
      final model = ResetPasswordRequestModel(email: email , newPassword: newPassword);
      final result = await _authRemoteDatasource.resetPassword(model);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = _extractApiMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }
}