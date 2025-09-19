import 'package:json_annotation/json_annotation.dart';

part 'payment_method_configuration_details.g.dart';

@JsonSerializable()
class PaymentMethodConfigurationDetails {
  final String? id;
  final dynamic parent;

  PaymentMethodConfigurationDetails({
    this.id,
    this.parent,
  });

  factory PaymentMethodConfigurationDetails.fromJson(
          Map<String, dynamic> json) =>
      _$PaymentMethodConfigurationDetailsFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PaymentMethodConfigurationDetailsToJson(this);
}
