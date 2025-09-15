class ProductEntity {
  final String id;
  final String title;
  final String imgCover;
  final double price;
  final double? priceAfterDiscount;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.imgCover,
    required this.price,
    this.priceAfterDiscount,
  });
}
