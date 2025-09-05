import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/cupertino.dart';


import '../../../../../core/contants/secure_storage.dart';
import '../../../data/models/change_password_request_model.dart';
import '../../../data/models/change_password_response_model.dart';
import '../../../domain/usecases/change_password_usecase.dart';
import 'states/change_password_states.dart';

@injectable
class ChangePasswordViewModel extends Cubit<ChangePasswordStates> {
  final ChangePasswordUseCases _changePasswordUseCases;

  ChangePasswordViewModel(this._changePasswordUseCases)
      : super(ChangePasswordInitial());

  final TextEditingController currentPasswordController =
  TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  Future<void> changePassword() async {
    emit(ChangePasswordLoading());

    final request = ChangePasswordRequestModel(
      password: currentPasswordController.text,
      newPassword: newPasswordController.text,
    );

    try {
      final ChangePasswordResponseModel result =
      await _changePasswordUseCases(request);

      if (result.token.isNotEmpty) {
        await SecureStorage.write(key: 'token', value: result.token);


        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        emit(ChangePasswordSuccess(result.message ?? "Password updated successfully"));
      } else {
        emit(ChangePasswordError("No token received from server"));
      }
    } catch (e) {
      emit(ChangePasswordError(e.toString()));
    }
  }
}
