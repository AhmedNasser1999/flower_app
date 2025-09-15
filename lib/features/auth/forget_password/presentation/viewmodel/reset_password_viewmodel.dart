import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/extensions/validations.dart';
import '../../../api/client/auth_api_client.dart';
import '../../../data/models/forget_password_models/reset_password_request_model.dart';
import 'states/reset_code_states.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._apiClient) : super(ResetPasswordInitialState());

  final AuthApiClient _apiClient;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? email;

  bool isFormValid = false;

  void setEmail(String emailAddress) {
    email = emailAddress;
  }

  void initializeListeners() {
    passwordController.addListener(_validateForm);
    confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    final isValid =
        Validations.validatePassword(password) && password == confirmPassword;

    if (isValid != isFormValid) {
      isFormValid = isValid;
      emit(ResetPasswordInitialState());
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!Validations.validatePassword(value)) {
      return 'Password must be at least 8 characters,\ninclude letters, numbers & special characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirmation is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> resetPassword() async {
    emit(ResetPasswordLoadingState());

    try {
      final newPassword = passwordController.text;

      final request = ResetPasswordRequestModel(
        email: email ?? '',
        newPassword: newPassword,
      );

      await _apiClient.resetPassword(request);

      emit(ResetPasswordSuccessState());
    } catch (e) {
      emit(ResetPasswordErrorState('Something went wrong: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
