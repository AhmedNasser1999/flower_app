import 'package:flower_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:flower_app/features/cart/domain/responses/cart_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToCartUseCase {
  final CartRepository _cartRepository;

  AddToCartUseCase(this._cartRepository);

  Future<CartResponse> call(String productId, int quantity) async {
    return await _cartRepository.addToCart(productId, quantity);
  }
}