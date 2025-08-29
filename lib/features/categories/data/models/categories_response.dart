import 'package:json_annotation/json_annotation.dart';

import '../../../most_selling_products/data/models/meta_data_model.dart';
import 'category_model.dart';

part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "categories")
  final List<Categories>? categories;

  CategoriesResponse ({
    this.message,
    this.metadata,
    this.categories,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return _$CategoriesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoriesResponseToJson(this);
  }
}







