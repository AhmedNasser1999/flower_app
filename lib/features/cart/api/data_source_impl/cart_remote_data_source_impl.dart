import 'package:flower_app/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:flower_app/features/cart/domain/responses/cart_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';

@LazySingleton(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiClient _apiClient;

  CartRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CartResponse> addToCart(String productId, int quantity) async {
    final request = AddToCartRequest(product: productId, quantity: quantity);
    return await _apiClient.addToCart(request);
  }

  @override
  Future<CartResponse> getCart() async {
    return await _apiClient.getCart();
  }

  @override
  Future<CartResponse> removeFromCart(String itemId) async {
    return await _apiClient.removeFromCart(itemId);
  }

  @override
  Future<CartResponse> updateCartItem(String itemId, int quantity) async {
    return await _apiClient.updateCartItem(itemId, {'quantity': quantity});
  }

  @override
  Future<CartResponse> clearCart() async {
    return await _apiClient.clearCart();
  }
}
