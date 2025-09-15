import '../../domain/entities/order_entity.dart';

abstract class OrderRepo {
  Future<List<OrderEntity>> getOrders();
}
