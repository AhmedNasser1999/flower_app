import 'package:flower_app/features/checkout/data/models/product_DTO.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_items_DTO.g.dart';
@JsonSerializable()
class OrderItemsDTO {
  final String id;
  final ProductDTO? product;
  final double? price;
  final int? quantity;
  final String? sId;

  OrderItemsDTO({
    required this.id,
    this.product,
    this.price,
    this.quantity,
    this.sId,
  });

  factory OrderItemsDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemsDTOToJson(this);
}
