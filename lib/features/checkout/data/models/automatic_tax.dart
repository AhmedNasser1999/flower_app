import 'package:json_annotation/json_annotation.dart';

part 'automatic_tax.g.dart';

@JsonSerializable()
class AutomaticTax {
  const AutomaticTax({
    this.enabled,
    this.liability,
    this.provider,
    this.status,
  });

  final bool? enabled;
  final String? liability;
  final String? provider;
  final String? status;

  factory AutomaticTax.fromJson(Map<String, dynamic> json) =>
      _$AutomaticTaxFromJson(json);

  Map<String, dynamic> toJson() => _$AutomaticTaxToJson(this);
}
