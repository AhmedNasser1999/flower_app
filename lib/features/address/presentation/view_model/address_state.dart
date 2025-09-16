part of 'address_cubit.dart';

@immutable
sealed class AddressState {}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressLoaded extends AddressState {
  final AddressResponse response;

  AddressLoaded(this.response);
}

final class AddressError extends AddressState {
  final String message;

  AddressError(this.message);
}

final class AddressOperationSuccess extends AddressState {
  final String message;

  AddressOperationSuccess(this.message);
}
