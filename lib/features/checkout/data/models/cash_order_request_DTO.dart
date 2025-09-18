import 'package:json_annotation/json_annotation.dart';
    part 'cash_order_request_DTO.g.dart';
@JsonSerializable()
class CashOrderRequestDTO {
  String? street;
  String? phone;
  String? city;
  String? lat;
  String? long;

  CashOrderRequestDTO({this.street, this.phone, this.city, this.lat, this.long});

  factory CashOrderRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$CashOrderRequestDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CashOrderRequestDTOToJson(this);
}
