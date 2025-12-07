// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccasionModel _$OccasionModelFromJson(Map<String, dynamic> json) =>
    OccasionModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      isSuperAdmin: json['isSuperAdmin'] as bool? ?? false,
      productsCount: (json['productsCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$OccasionModelToJson(OccasionModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'image': instance.image,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isSuperAdmin': instance.isSuperAdmin,
      'productsCount': instance.productsCount,
    };
