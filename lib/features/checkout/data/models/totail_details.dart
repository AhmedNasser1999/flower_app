import 'package:json_annotation/json_annotation.dart';
part 'totail_details.g.dart';

@JsonSerializable()
class TotalDetails {
  @JsonKey(name: "amount_discount")
  final int amountDiscount;

  @JsonKey(name: "amount_shipping")
  final int amountShipping;

  @JsonKey(name: "amount_tax")
  final int amountTax;

  TotalDetails({
    required this.amountDiscount,
    required this.amountShipping,
    required this.amountTax,
  });

  factory TotalDetails.fromJson(Map<String, dynamic> json) =>
      _$TotalDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TotalDetailsToJson(this);
}
