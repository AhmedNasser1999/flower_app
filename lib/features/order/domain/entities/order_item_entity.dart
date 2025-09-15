class OrderItemEntity {
  final String productId;
  final String title;
  final String imgCover;
  final double price;
  final int quantity;

  OrderItemEntity({
    required this.productId,
    required this.title,
    required this.imgCover,
    required this.price,
    required this.quantity,
  });
}
