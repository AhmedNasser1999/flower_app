import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';

@JsonSerializable()
class Products {
  @JsonKey(name: "rateAvg", defaultValue: 0)
  final int rateAvg;

  @JsonKey(name: "rateCount", defaultValue: 0)
  final int rateCount;

  @JsonKey(name: "_id")
  final String Id;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "slug")
  final String slug;

  @JsonKey(name: "description")
  final String description;

  @JsonKey(name: "imgCover")
  final String imgCover;

  @JsonKey(name: "images", defaultValue: [])
  final List<String> images;

  @JsonKey(name: "price", defaultValue: 0)
  final int price;

  @JsonKey(name: "priceAfterDiscount", defaultValue: 0)
  final int priceAfterDiscount;

  @JsonKey(name: "quantity", defaultValue: 0)
  final int quantity;

  @JsonKey(name: "category", defaultValue: "")
  final String category;

  @JsonKey(name: "occasion", defaultValue: "")
  final String occasion;

  @JsonKey(name: "createdAt", defaultValue: "")
  final String createdAt;

  @JsonKey(name: "updatedAt", defaultValue: "")
  final String updatedAt;

  @JsonKey(name: "__v", defaultValue: 0)
  final int V;

  @JsonKey(name: "isSuperAdmin", defaultValue: false)
  final bool isSuperAdmin;

  @JsonKey(name: "sold", defaultValue: 0)
  final int sold;

  Products({
    required this.rateAvg,
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
    required this.category,
    required this.occasion,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.isSuperAdmin,
    required this.sold,
  });

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}
