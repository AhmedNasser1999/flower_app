class CashOrderEntity {
  final String message;
  final int totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String createdAt;
  final String updatedAt;
  final String orderNumber;

  CashOrderEntity({
    this.message = "",
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
  });
}

class CashOrderItemEntity {
  final String id;
  final String productId;
  final String title;
  final String imgCover;
  final int price;
  final int quantity;

  CashOrderItemEntity({
    required this.id,
    required this.productId,
    required this.title,
    required this.imgCover,
    required this.price,
    required this.quantity,
  });
}
