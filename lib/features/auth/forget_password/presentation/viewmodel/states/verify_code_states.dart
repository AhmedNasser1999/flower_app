sealed class VerifyCodeStates {}

class VerifyCodeInitialStates extends VerifyCodeStates {}

class VerifyCodeLoadingStates extends VerifyCodeStates {}

class VerifyCodeSuccessStates extends VerifyCodeStates {}

class VerifyCodeResendStates extends VerifyCodeStates {}

class VerifyCodeErrorStates extends VerifyCodeStates {
  final String message;
  VerifyCodeErrorStates(this.message);
}
