import 'package:flower_app/features/cart/domain/responses/cart_response.dart';


abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartResponse cartResponse;

  CartLoaded(this.cartResponse);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}