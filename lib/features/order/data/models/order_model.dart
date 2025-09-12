import 'package:json_annotation/json_annotation.dart';

import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {

  @JsonKey(name: "_id")
  final String id;
  final String orderNumber;
  final double totalPrice;
  final String state;
  final String createdAt;
  final List<OrderItemModel> orderItems;

  OrderModel(this.createdAt, {
    required this.id,
    required this.orderNumber,
    required this.totalPrice,
    required this.state,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}