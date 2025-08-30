import 'package:flower_app/features/categories/data/models/category_model.dart';
import 'package:flower_app/features/most_selling_products/data/models/meta_data_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'categories_response.g.dart';
@JsonSerializable()
class CategoriesResponse {
  String? message;
  Metadata? metadata;
  List<Categories>? categories;

  CategoriesResponse({this.message, this.metadata, this.categories});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}
