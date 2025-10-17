import '../entities/order.dart';

abstract class OrderRepository {
  Future<Order?> getOrderById({required String userId, required String orderId});
  Stream<Order?> watchOrderById({required String userId, required String orderId});
}

