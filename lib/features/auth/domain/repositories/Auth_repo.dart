import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:retrofit/retrofit.dart';

abstract class AuthRepo {
  Future<RegisterResponse> signUp(@Body() RegisterRequest registerRequest);
}
