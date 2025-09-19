import 'package:json_annotation/json_annotation.dart';
part 'customer_details.g.dart';

@JsonSerializable()
class CustomerDetails {
  const CustomerDetails({
    this.address,
    this.email,
    this.name,
    this.phone,
    this.taxExempt,
    this.taxIds,
  });

  final String? address;
  final String? email;
  final String? name;
  final String? phone;
  @JsonKey(name: 'tax_exempt')
  final String? taxExempt;
  @JsonKey(name: 'tax_ids')
  final List<String>? taxIds;

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      _$CustomerDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailsToJson(this);
}
