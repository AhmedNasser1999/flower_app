
import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';

abstract class AuthRemoteDatasource {
  Future<RegisterResponse> signUp(RegisterRequest registerRequest);
}