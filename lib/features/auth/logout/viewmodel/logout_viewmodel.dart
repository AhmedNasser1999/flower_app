import 'package:flower_app/features/auth/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/services/auth_service.dart';
import '../../../../core/contants/secure_storage.dart';
import 'logout_states.dart';

@injectable
class LogoutViewModel extends Cubit<LogoutStates> {
  final LogoutUseCase logoutUseCase;
  LogoutViewModel(this.logoutUseCase) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    try {
      final result = await logoutUseCase();
      await SecureStorage.delete("auth_token");
      await SecureStorage.delete("user_id");

      emit(LogoutSuccess(result));
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }
}