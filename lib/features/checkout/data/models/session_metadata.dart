import 'package:json_annotation/json_annotation.dart';

part 'session_metadata.g.dart';

@JsonSerializable()
class SessionMetadata {
  final String? city;
  final String? lat;
  final String? long;
  final String? phone;
  final String? street;

  SessionMetadata({
    this.city,
    this.lat,
    this.long,
    this.phone,
    this.street,
  });

  factory SessionMetadata.fromJson(Map<String, dynamic> json) =>
      _$SessionMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionMetadataToJson(this);
}
