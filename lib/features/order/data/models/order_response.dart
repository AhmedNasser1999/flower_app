
import 'package:json_annotation/json_annotation.dart';

import 'order_model.dart';
part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  final String message;
  final List<OrderModel> orders;

  OrderResponse({required this.message, required this.orders});

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
