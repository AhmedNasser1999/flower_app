import 'package:flower_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:flower_app/features/cart/domain/responses/cart_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartItemUseCase {
  final CartRepository _cartRepository;

  UpdateCartItemUseCase(this._cartRepository);

  Future<CartResponse> call(String itemId, int quantity) async {
    return await _cartRepository.updateCartItem(itemId, quantity);
  }
}
