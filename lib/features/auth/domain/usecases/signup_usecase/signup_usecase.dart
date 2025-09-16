import 'package:flower_app/features/auth/data/models/signup_model/signup_request_model.dart';
import 'package:flower_app/features/auth/data/models/signup_model/signup_response_model.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupUsecase {
  final AuthRepo authRepo;

  SignupUsecase(this.authRepo);

  Future<RegisterResponse> invoke(RegisterRequest registerRequest) {
    return authRepo.signUp(registerRequest);
  }
}