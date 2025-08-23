import 'package:flower_app/features/auth/api/client/auth_api_client.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final AuthApiClient _authApiClient;

  AuthRemoteDatasourceImpl(this._authApiClient);

  @override
  Future<RegisterResponse> signUp(RegisterRequest registerRequest) {
    return _authApiClient.signUp(registerRequest);
  }
}
