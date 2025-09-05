abstract class ChangePasswordStates {}

class ChangePasswordInitial extends ChangePasswordStates {}

class ChangePasswordLoading extends ChangePasswordStates {}

class ChangePasswordSuccess extends ChangePasswordStates {
  final String message;
  ChangePasswordSuccess(this.message);
}

class ChangePasswordError extends ChangePasswordStates {
  final String message;

  ChangePasswordError(this.message);
}
