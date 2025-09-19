import 'package:flower_app/features/checkout/data/models/cash_order_request_DTO.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cash_order_request.g.dart';

@JsonSerializable()
class CashOrderRequest {
  CashOrderRequestDTO? shippingAddress;

  CashOrderRequest({this.shippingAddress});

  factory CashOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CashOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CashOrderRequestToJson(this);
}
