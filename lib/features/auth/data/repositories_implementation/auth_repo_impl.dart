
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failure.dart';

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




}