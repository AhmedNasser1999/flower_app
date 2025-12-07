import 'package:flower_app/features/checkout/data/models/order_DTO.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cash_order_response.g.dart';

@JsonSerializable()
class CashOrderResponse {
  String? message;
  OrderDTO? order;

  CashOrderResponse({this.message, this.order});

  factory CashOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CashOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CashOrderResponseToJson(this);
}
