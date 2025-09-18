import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: "_id")
  final String id;
  final String title;
  final String imgCover;
  final double price;
  final double? priceAfterDiscount;

  ProductModel({
    required this.id,
    required this.title,
    required this.imgCover,
    required this.price,
    this.priceAfterDiscount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
