import 'package:flower_app/features/checkout/data/models/product_DTO.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_items_DTO.g.dart';

@JsonSerializable()
class OrderItemsDTO {
  @JsonKey(name: '_id')
  final String id; // force default

  final ProductDTO? product;

  final double price;
  final int quantity;

  @JsonKey(name: 'sId')
  final String sId;

  OrderItemsDTO({
    this.id = "",
    this.product,
    this.price = 0.0,
    this.quantity = 0,
    this.sId = "",
  });

  factory OrderItemsDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemsDTOToJson(this);
}
