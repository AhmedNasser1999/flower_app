// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_DTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDTO _$ProductDTOFromJson(Map<String, dynamic> json) => ProductDTO(
      rateAvg: (json['rateAvg'] as num?)?.toInt(),
      rateCount: (json['rateCount'] as num?)?.toInt(),
      sId: json['sId'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      imgCover: json['imgCover'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      price: (json['price'] as num?)?.toInt(),
      priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
      category: json['category'] as String?,
      occasion: json['occasion'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: (json['iV'] as num?)?.toInt(),
      sold: (json['sold'] as num?)?.toInt(),
      isSuperAdmin: json['isSuperAdmin'] as bool?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ProductDTOToJson(ProductDTO instance) =>
    <String, dynamic>{
      'rateAvg': instance.rateAvg,
      'rateCount': instance.rateCount,
      'sId': instance.sId,
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
      'iV': instance.iV,
      'sold': instance.sold,
      'isSuperAdmin': instance.isSuperAdmin,
      'id': instance.id,
    };
