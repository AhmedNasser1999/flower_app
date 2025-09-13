abstract class ResetPasswordState {}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordSuccessState extends ResetPasswordState {}

class ResetPasswordErrorState extends ResetPasswordState {
  final String message;
  ResetPasswordErrorState(this.message);
}
