import 'package:flower_app/features/categories/domain/entities/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';

@JsonSerializable()
class Categories extends CategoryEntity {
  String? sId;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;
  bool? isSuperAdmin;
  int? productsCount;

  Categories(
      {this.sId,
      this.name,
      this.slug,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.isSuperAdmin,
      this.productsCount})
      : super(id: '', catName: '', catImage: '');

  factory Categories.fromJson(json) => _$CategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}
