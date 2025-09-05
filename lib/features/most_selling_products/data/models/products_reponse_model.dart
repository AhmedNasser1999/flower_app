import 'package:flower_app/features/most_selling_products/data/models/products_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'meta_data_model.dart';

part 'products_reponse_model.g.dart';

@JsonSerializable()
class ProductsResponseModel {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "metadata")
  final Metadata metadata;
  @JsonKey(name: "products")
  final List<Products> products;

  ProductsResponseModel ({
    required this.message,
    required this.metadata,
    required this.products,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ProductsResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsResponseModelToJson(this);
  }
}


