
import 'package:flower_app/features/auth/data/models/login_models/login_request_model.dart';
import 'package:flower_app/features/auth/data/models/login_models/login_response_model.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:flower_app/features/auth/domain/responses/auth_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {

  final AuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  Future<AuthResponse<LoginResponse>> call(LoginRequest loginRequest)
  {
    return _authRepo.login(loginRequest);
  }


}