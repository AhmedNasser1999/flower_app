import 'dart:async';

import 'package:flower_app/features/auth/forget_password/presentation/viewmodel/states/verify_code_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../domain/usecases/forget_password_usecase/forget_password_usecase.dart';
import '../../../domain/usecases/verify_code_usecase/verify_code_usecase.dart';

@injectable
class VerifyCodeCubit extends Cubit<VerifyCodeStates> {
  final VerifyCodeUseCase _verifyCodeUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  String enteredCode = '';
  String? email;
  bool isResendEnabled = true;
  Timer? _resendTimer;

  VerifyCodeCubit(this._verifyCodeUseCase, this._forgetPasswordUseCase) : super(VerifyCodeInitialStates());

  void setEmail(String emailAddress) {
    email = emailAddress;
  }

  void updateCode(String code) {
    enteredCode = code;
    emit(VerifyCodeInitialStates());
  }

  Future<void> resendCode() async {
    if (!isResendEnabled) return;

    isResendEnabled = false;
    emit(VerifyCodeLoadingStates());

    final result = await _forgetPasswordUseCase(email!);
    if (result.isSuccess) {
      emit(VerifyCodeResendStates());
    } else {
      emit(VerifyCodeErrorStates(result.error ?? 'Unknown error'));
    }
    _startResendCooldown();
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    _resendTimer = Timer(const Duration(seconds: 30), () {
      isResendEnabled = true;
      emit(VerifyCodeInitialStates());
    });
  }

  Future<void> verify(BuildContext context) async {
    if (enteredCode.length < 6) {
      emit(VerifyCodeErrorStates("Code must be 6 digits"));
      return;
    }

    emit(VerifyCodeLoadingStates());

    final result = await _verifyCodeUseCase(enteredCode);
    if (result.isSuccess) {
      emit(VerifyCodeSuccessStates());
      Navigator.pushNamed(
        context,
        AppRoutes.resetPassword,
        arguments: email ?? '',
      );
    } else {
      emit(VerifyCodeErrorStates(result.error ?? 'Unknown error'));
    }
  }
}

