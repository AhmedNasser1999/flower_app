import 'package:json_annotation/json_annotation.dart';
part 'adaptive_pricing.g.dart';

@JsonSerializable()
class AdaptivePricing {
  const AdaptivePricing({
    this.enabled,
  });

  final bool? enabled;

  factory AdaptivePricing.fromJson(Map<String, dynamic> json) =>
      _$AdaptivePricingFromJson(json);

  Map<String, dynamic> toJson() => _$AdaptivePricingToJson(this);
}
