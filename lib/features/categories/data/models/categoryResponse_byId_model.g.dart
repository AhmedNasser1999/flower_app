// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryResponse_byId_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDetailsResponse _$CategoryDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryDetailsResponse(
      message: json['message'] as String?,
      category: json['category'] == null
          ? null
          : Categories.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryDetailsResponseToJson(
        CategoryDetailsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'category': instance.category,
    };
