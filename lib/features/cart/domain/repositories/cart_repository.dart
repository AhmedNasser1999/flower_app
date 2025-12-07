import 'package:flower_app/features/cart/domain/responses/cart_response.dart';

abstract class CartRepository {
  Future<CartResponse> addToCart(String productId, int quantity);
  Future<CartResponse> getCart();
  Future<CartResponse> removeFromCart(String itemId);
  Future<CartResponse> updateCartItem(String itemId, int quantity);
  Future<CartResponse> clearCart();
}
