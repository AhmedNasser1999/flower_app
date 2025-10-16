import 'package:injectable/injectable.dart' hide Order;
import '../entities/order.dart';
import '../repositories/order_repository.dart';

@injectable
class WatchOrderUpdatesUseCase {
  final OrderRepository repository;
  WatchOrderUpdatesUseCase(this.repository);

  Stream<Order?> call({required String userId, required String orderId}) {
    return repository.watchOrderById(userId: userId, orderId: orderId);
  }
}
