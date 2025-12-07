import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:injectable/injectable.dart';
import '../../responses/auth_response.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _forgetPasswordRepo;

  ForgetPasswordUseCase(this._forgetPasswordRepo);

  Future<AuthResponse<String>> call(String email) {
    return _forgetPasswordRepo.forgetPassword(email);
  }
}
