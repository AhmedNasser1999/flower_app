import 'dart:developer';

import 'package:flower_app/core/common/widgets/custom_snackbar_widget.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
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

  Future<void> addToCart(
    String productId,
    int quantity,
    BuildContext context,
  ) async {
    var local = AppLocalizations.of(context)!;
    emit(CartLoading());
    try {
      final response = await _addToCartUseCase(productId, quantity);
      if (!isClosed) {
        emit(CartLoaded(response));
        showCustomSnackBar(context, local.productAddedToCart, isError: false);
        await _refreshCart();
      }
    } catch (e, s) {
      if (!isClosed) {
        emit(CartError(e.toString()));
        print(s);
        showCustomSnackBar(context, local.thisItemIsSoldOut);
      }
    }
  }

  Future<void> getCart() async {
    if (isClosed) return;
    emit(CartLoading());
    try {
      final response = await _getCartUseCase();
      if (!isClosed) {
        emit(CartLoaded(response));
      }
    } catch (e) {
      if (!isClosed) {
        emit(CartError(e.toString()));
      }
    }
  }

  Future<void> removeFromCart(String itemId, BuildContext context) async {
    var local = AppLocalizations.of(context)!;
    if (isClosed) return;
    emit(CartLoading());
    try {
      final response = await _removeFromCartUseCase(itemId);
      if (!isClosed) {
        // First emit the immediate response
        emit(CartLoaded(response));
        showCustomSnackBar(context, local.itemRemovedFromCart, isError: false);
        await _refreshCart();
      }
    } catch (e) {
      if (!isClosed) {
        emit(CartError(e.toString()));
      }
    }
  }

  Future<void> updateCartItem(String itemId, int quantity) async {
    if (isClosed) return;
    emit(CartLoading());
    try {
      final response = await _updateCartItemUseCase(itemId, quantity);
      if (!isClosed) {
        emit(CartLoaded(response));
        await _refreshCart();
      }
    } catch (e) {
      if (!isClosed) {
        emit(CartError(e.toString()));
      }
    }
  }

  Future<void> clearCart(BuildContext context) async {
    var local = AppLocalizations.of(context)!;
    if (isClosed) return;
    emit(CartLoading());
    try {
      final response = await _clearCartUseCase();
      if (!isClosed) {
        emit(CartLoaded(response));
        await _refreshCart();
      }
    } catch (e) {
      if (!isClosed) {
        emit(CartError(e.toString()));
      }
    }
  }

  Future<void> _refreshCart() async {
    if (isClosed) return;
    try {
      final response = await _getCartUseCase();
      if (!isClosed) {
        emit(CartLoaded(response));
      }
    } catch (e) {
      if (!isClosed) {
        log('Error refreshing cart: $e');
      }
    }
  }
}
