// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_items_DTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemsDTO _$OrderItemsDTOFromJson(Map<String, dynamic> json) =>
    OrderItemsDTO(
      id: json['_id'] as String? ?? "",
      product: json['product'] == null
          ? null
          : ProductDTO.fromJson(json['product'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      sId: json['sId'] as String? ?? "",
    );

Map<String, dynamic> _$OrderItemsDTOToJson(OrderItemsDTO instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'product': instance.product,
      'price': instance.price,
      'quantity': instance.quantity,
      'sId': instance.sId,
    };
