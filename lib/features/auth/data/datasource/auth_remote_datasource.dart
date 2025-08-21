import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';

abstract class AuthRemoteDatasource {

  Future<LoginResponse> login(LoginRequest loginRequest);
}