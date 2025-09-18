import 'package:json_annotation/json_annotation.dart';

part 'custom_text.g.dart';

@JsonSerializable()
class CustomText {
  const CustomText({
    this.afterSubmit,
    this.shippingAddress,
    this.submit,
    this.termsOfServiceAcceptance,
  });

  @JsonKey(name: 'after_submit')
  final String? afterSubmit;

  @JsonKey(name: 'shipping_address')
  final String? shippingAddress;

  final String? submit;

  @JsonKey(name: 'terms_of_service_acceptance')
  final String? termsOfServiceAcceptance;

  factory CustomText.fromJson(Map<String, dynamic> json) =>
      _$CustomTextFromJson(json);

  Map<String, dynamic> toJson() => _$CustomTextToJson(this);
}
