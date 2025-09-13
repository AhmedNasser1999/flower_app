abstract class LogoutStates {}

class LogoutInitial extends LogoutStates {}

class LogoutLoading extends LogoutStates {}

class LogoutSuccess extends LogoutStates {
  final String message;
  LogoutSuccess(this.message);
}

class LogoutError extends LogoutStates {
  final String message;
  LogoutError(this.message);
}
