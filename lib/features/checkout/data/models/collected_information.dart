import 'package:json_annotation/json_annotation.dart';

part 'collected_information.g.dart';

@JsonSerializable()
class CollectedInformation {
  const CollectedInformation({
    this.shippingDetails,
  });

  @JsonKey(name: 'shipping_details')
  final String? shippingDetails;

  factory CollectedInformation.fromJson(Map<String, dynamic> json) =>
      _$CollectedInformationFromJson(json);

  Map<String, dynamic> toJson() => _$CollectedInformationToJson(this);
}
