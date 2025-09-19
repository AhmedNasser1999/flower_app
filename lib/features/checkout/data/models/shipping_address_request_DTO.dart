import 'package:json_annotation/json_annotation.dart';
part 'shipping_address_request_DTO.g.dart';

@JsonSerializable()
class ShippingAddress {
  const ShippingAddress({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
  });

  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}
