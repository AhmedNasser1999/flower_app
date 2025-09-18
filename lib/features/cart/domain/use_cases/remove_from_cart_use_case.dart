import 'package:flower_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:flower_app/features/cart/domain/responses/cart_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveFromCartUseCase {
  final CartRepository _cartRepository;

  RemoveFromCartUseCase(this._cartRepository);

  Future<CartResponse> call(String itemId) async {
    return await _cartRepository.removeFromCart(itemId);
  }
}
