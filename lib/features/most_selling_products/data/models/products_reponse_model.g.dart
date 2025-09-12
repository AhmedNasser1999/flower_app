// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_reponse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsResponseModel _$ProductsResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProductsResponseModel(
      message: json['message'] as String,
      metadata: Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsResponseModelToJson(
        ProductsResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'products': instance.products,
    };
