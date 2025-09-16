// features/occasion/data/models/occasion_response_model.dart
import 'package:json_annotation/json_annotation.dart';
import 'occasion_model.dart';

part 'occasion_response_model.g.dart';

@JsonSerializable()
class OccasionsResponse {
  @JsonKey(name: "message", defaultValue: "")
  final String message;

  @JsonKey(name: "metadata")
  final Metadata metadata;

  @JsonKey(name: "occasions", defaultValue: [])
  final List<OccasionModel> occasions;

  OccasionsResponse({
    required this.message,
    required this.metadata,
    required this.occasions,
  });

  factory OccasionsResponse.fromJson(Map<String, dynamic> json) =>
      _$OccasionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionsResponseToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage", defaultValue: 1)
  final int currentPage;

  @JsonKey(name: "limit", defaultValue: 10)
  final int limit;

  @JsonKey(name: "totalPages", defaultValue: 1)
  final int totalPages;

  @JsonKey(name: "totalItems", defaultValue: 0)
  final int totalItems;

  Metadata({
    required this.currentPage,
    required this.limit,
    required this.totalPages,
    required this.totalItems,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
