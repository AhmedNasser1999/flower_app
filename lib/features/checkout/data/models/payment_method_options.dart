import 'package:flower_app/features/checkout/data/models/card.dart';
import 'package:json_annotation/json_annotation.dart';
part 'payment_method_options.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentMethodOptions {
  final Card? card;

  PaymentMethodOptions({this.card});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodOptionsToJson(this);
}
