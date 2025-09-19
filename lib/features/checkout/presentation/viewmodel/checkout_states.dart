sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutError extends CheckoutState {
  final String message;
  CheckoutError(this.message);
}

final class CheckoutCashSuccess extends CheckoutState {
  final String message;
  CheckoutCashSuccess(this.message);
}

final class CheckoutCardSuccess extends CheckoutState {
  final String url;
  CheckoutCardSuccess(this.url);
}
