// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      json['createdAt'] as String,
      id: json['_id'] as String,
      orderNumber: json['orderNumber'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      state: json['state'] as String,
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'orderNumber': instance.orderNumber,
      'totalPrice': instance.totalPrice,
      'state': instance.state,
      'createdAt': instance.createdAt,
      'orderItems': instance.orderItems,
    };
