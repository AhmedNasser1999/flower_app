import 'package:json_annotation/json_annotation.dart';
part 'product_DTO.g.dart';

@JsonSerializable()
class ProductDTO {
  int? rateAvg;
  int? rateCount;
  String? sId;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  int? price;
  int? priceAfterDiscount;
  int? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? sold;
  bool? isSuperAdmin;
  String? id;

  ProductDTO(
      {this.rateAvg,
      this.rateCount,
      this.sId,
      this.title,
      this.slug,
      this.description,
      this.imgCover,
      this.images,
      this.price,
      this.priceAfterDiscount,
      this.quantity,
      this.category,
      this.occasion,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.sold,
      this.isSuperAdmin,
      this.id});

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDTOToJson(this);
}
