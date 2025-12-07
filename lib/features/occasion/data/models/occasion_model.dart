// features/occasion/data/models/occasion_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'occasion_model.g.dart';

@JsonSerializable()
class OccasionModel {
  @JsonKey(name: "_id")
  final String id;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "slug")
  final String slug;

  @JsonKey(name: "image")
  final String image;

  @JsonKey(name: "createdAt")
  final String createdAt;

  @JsonKey(name: "updatedAt")
  final String updatedAt;

  @JsonKey(name: "isSuperAdmin", defaultValue: false)
  final bool isSuperAdmin;

  @JsonKey(name: "productsCount", defaultValue: 0)
  final int productsCount;

  OccasionModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.isSuperAdmin,
    required this.productsCount,
  });

  factory OccasionModel.fromJson(Map<String, dynamic> json) =>
      _$OccasionModelFromJson(json);

  Map<String, dynamic> toJson() => _$OccasionModelToJson(this);
}
