// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      rateAvg: (json['rateAvg'] as num?)?.toInt() ?? 0,
      rateCount: (json['rateCount'] as num?)?.toInt() ?? 0,
      Id: json['_id'] as String,
      title: json['title'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      imgCover: json['imgCover'] as String,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      price: (json['price'] as num?)?.toInt() ?? 0,
      priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      category: json['category'] as String? ?? '',
      occasion: json['occasion'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      V: (json['__v'] as num?)?.toInt() ?? 0,
      isSuperAdmin: json['isSuperAdmin'] as bool? ?? false,
      sold: (json['sold'] as num?)?.toInt() ?? 0,
      id: json['id'] as String? ?? '',
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'rateAvg': instance.rateAvg,
      'rateCount': instance.rateCount,
      '_id': instance.Id,
      'title': instance.title,
      'slug': instance.slug,
      'description': instance.description,
      'imgCover': instance.imgCover,
      'images': instance.images,
      'price': instance.price,
      'priceAfterDiscount': instance.priceAfterDiscount,
      'quantity': instance.quantity,
      'category': instance.category,
      'occasion': instance.occasion,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.V,
      'isSuperAdmin': instance.isSuperAdmin,
      'sold': instance.sold,
      'id': instance.id,
    };
