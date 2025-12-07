import 'package:injectable/injectable.dart' hide Order;
import '../entities/order.dart';
import '../repositories/order_repository.dart';

@injectable
class GetOrderByIdUseCase {
  final OrderRepository repository;
  GetOrderByIdUseCase(this.repository);

  Future<Order?> call({required String userId, required String orderId}) async {
    return await repository.getOrderById(userId: userId, orderId: orderId);
  }
}
