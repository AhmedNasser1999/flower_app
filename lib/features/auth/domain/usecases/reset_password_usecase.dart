import 'package:injectable/injectable.dart';
import '../repositories/Auth_repo.dart';
import '../responses/auth_response.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _forgetPasswordRepo;

  ResetPasswordUseCase(this._forgetPasswordRepo);

  Future<AuthResponse<String>> call(String email, String newPassword) {
    return _forgetPasswordRepo.resetPassword(email, newPassword);
  }
}
