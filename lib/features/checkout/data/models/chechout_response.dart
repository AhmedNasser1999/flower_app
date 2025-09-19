import 'package:flower_app/features/checkout/data/models/session.dart';
import 'package:json_annotation/json_annotation.dart';
part 'chechout_response.g.dart';

@JsonSerializable()
class CheckoutResponse {
  const CheckoutResponse({
    this.message,
    this.session,
  });

  final String? message;
  final Session? session;

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutResponseToJson(this);
}
