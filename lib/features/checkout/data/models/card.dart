import 'package:json_annotation/json_annotation.dart';
part 'card.g.dart';

@JsonSerializable()
class Card {
  const Card({
    this.requestThreeDSecure,
  });

  @JsonKey(name: 'request_three_d_secure')
  final String? requestThreeDSecure;

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}
