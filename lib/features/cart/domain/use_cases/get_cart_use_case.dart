import 'package:flower_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:flower_app/features/cart/domain/responses/cart_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartUseCase {
  final CartRepository _cartRepository;

  GetCartUseCase(this._cartRepository);

  Future<CartResponse> call() async {
    return await _cartRepository.getCart();
  }
}