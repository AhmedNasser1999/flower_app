import 'package:flower_app/features/auth/api/client/auth_api_client.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {

  final AuthApiClient _authApiClient;

  AuthRemoteDatasourceImpl(this._authApiClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _authApiClient.login(loginRequest);

  }

  


}