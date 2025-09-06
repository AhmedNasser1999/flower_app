import 'package:flower_app/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:flower_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:injectable/injectable.dart';

import '../../domain/responses/cart_response.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl(this._remoteDataSource);

  @override
  Future<CartResponse> addToCart(String productId, int quantity) async {
    return await _remoteDataSource.addToCart(productId, quantity);
  }

  @override
  Future<CartResponse> getCart() async {
    return await _remoteDataSource.getCart();
  }

  @override
  Future<CartResponse> removeFromCart(String itemId) async {
    return await _remoteDataSource.removeFromCart(itemId);
  }

  @override
  Future<CartResponse> updateCartItem(String itemId, int quantity) async {
    return await _remoteDataSource.updateCartItem(itemId, quantity);
  }

  @override
  Future<CartResponse> clearCart() async {
    return await _remoteDataSource.clearCart();
  }

}