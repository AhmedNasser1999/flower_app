import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

@injectable
class SignupUsecase {
  final AuthRepo _authRepo;
  @factoryMethod
  SignupUsecase(this._authRepo);

  Future<RegisterResponse> invoke(@Body() RegisterRequest registerRequest) =>
      _authRepo.signUp(registerRequest);
}
