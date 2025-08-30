import 'package:json_annotation/json_annotation.dart';
part 'metadata_model.g.dart';
@JsonSerializable()
class Metadata {
  int? currentPage;
  int? limit;
  int? totalPages;
  int? totalItems;

  Metadata({this.currentPage, this.limit, this.totalPages, this.totalItems});

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
