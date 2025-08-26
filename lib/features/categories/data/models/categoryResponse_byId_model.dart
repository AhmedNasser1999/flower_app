import 'package:json_annotation/json_annotation.dart';
import 'category_model.dart';

part 'categoryResponse_byId_model.g.dart';

@JsonSerializable()
class CategoryDetailsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "category")
  final Categories? category;

  CategoryDetailsResponse({
    this.message,
    this.category,
  });

  factory CategoryDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDetailsResponseToJson(this);
}
