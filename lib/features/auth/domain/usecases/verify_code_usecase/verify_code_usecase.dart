import 'package:injectable/injectable.dart';
import '../../repositories/Auth_repo.dart';
import '../../responses/auth_response.dart';

@injectable
class VerifyCodeUseCase{
  final AuthRepo _forgetPasswordRepo;

  VerifyCodeUseCase(this._forgetPasswordRepo);

  Future<AuthResponse<String>> call(String code) {
    return _forgetPasswordRepo.verifyCode(code);
  }
}