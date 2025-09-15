import 'order_item_entity.dart';

class OrderEntity {
  final String id;
  final String orderNumber;
  final double totalPrice;
  final String state;
  final DateTime createdAt;
  final List<OrderItemEntity> orderItems;

  OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.totalPrice,
    required this.state,
    required this.createdAt,
    required this.orderItems,
  });
}
