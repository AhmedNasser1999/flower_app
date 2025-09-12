import 'package:flower_app/features/order/data/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  @JsonKey(name: "_id")
  final String id;
  final ProductModel product;
  final double price;
  final int quantity;

  OrderItemModel({
    required this.id,
    required this.product,
    required this.price,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
