import 'package:injectable/injectable.dart';
import '../repositories/cart_repository.dart';
import '../responses/cart_response.dart';

@injectable
class ClearCartUseCase {
  final CartRepository _repository;

  ClearCartUseCase(this._repository);

  Future<CartResponse> call() async {
    return await _repository.clearCart();
  }
}
