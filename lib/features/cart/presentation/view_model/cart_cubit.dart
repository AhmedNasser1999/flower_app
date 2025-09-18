
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_cases/add_to_cart_use_case.dart';
import '../../domain/use_cases/clear_cart_use_case.dart';
import '../../domain/use_cases/get_cart_use_case.dart';
import '../../domain/use_cases/remove_from_cart_use_case.dart';
import '../../domain/use_cases/update_cart_use_case.dart';
import 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final AddToCartUseCase _addToCartUseCase;
  final GetCartUseCase _getCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final UpdateCartItemUseCase _updateCartItemUseCase;
  final ClearCartUseCase _clearCartUseCase;

  CartCubit(
      this._addToCartUseCase,
      this._getCartUseCase,
      this._removeFromCartUseCase,
      this._updateCartItemUseCase,
      this._clearCartUseCase,
      ) : super(CartInitial());

  Future<void> addToCart(String productId, int quantity,BuildContext context,{VoidCallback? onSuccess}) async {
    emit(CartLoading());
    try {
      final response = await _addToCartUseCase(productId, quantity);
      emit(CartLoaded(response));
      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text('Product added to cart')));
      onSuccess?.call();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      final response = await _getCartUseCase();
      emit(CartLoaded(response));
    } catch (e,s) {
      emit(CartError(e.toString()));
      print('sttttaaack:::::  $s');
    }
  }

  Future<void> removeFromCart(String itemId) async {
    emit(CartLoading());
    try {
      final response = await _removeFromCartUseCase(itemId);
      emit(CartLoaded(response));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> updateCartItem(String itemId, int quantity) async {
    emit(CartLoading());
    try {
      final response = await _updateCartItemUseCase(itemId, quantity);
      emit(CartLoaded(response));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }


  Future<void> clearCart(BuildContext context) async {
    emit(CartLoading());
    try {
      final response = await _clearCartUseCase();
      emit(CartLoaded(response));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cart cleared successfully")),
      );
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}