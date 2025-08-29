class ProductsEntity {
  final int rateAvg;
  final int? rateCount;
  final String Id;
  final String title;
  final String slug;
  final String description;
  final String imgCover;
  final List<String> images;
  final int price;
  final int priceAfterDiscount;
  final int quantity;
  final int sold;
  final String id;
  final String category;
  final String occasion;

  ProductsEntity(
      {required this.rateAvg,
      required this.rateCount,
      required this.Id,
      required this.title,
      required this.slug,
      required this.description,
      required this.imgCover,
      required this.images,
      required this.price,
      required this.priceAfterDiscount,
      required this.quantity,
      required this.sold,
      required this.category,
      required this.id,
      required this.occasion});
}
