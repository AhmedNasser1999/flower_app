import 'package:flower_app/features/checkout/data/models/shipping_address_request_DTO.dart';
import 'package:json_annotation/json_annotation.dart';
part 'checkout_request.g.dart';

@JsonSerializable()
class CheckoutRequest {
  ShippingAddress? shippingAddress;

  CheckoutRequest({this.shippingAddress});

  factory CheckoutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRequestToJson(this);
}
