// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_DTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDTO _$OrderDTOFromJson(Map<String, dynamic> json) => OrderDTO(
      user: json['user'] as String?,
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItemsDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      paymentType: json['paymentType'] as String?,
      isPaid: json['isPaid'] as bool?,
      isDelivered: json['isDelivered'] as bool?,
      state: json['state'] as String?,
      sId: json['sId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      orderNumber: json['orderNumber'] as String?,
      iV: (json['iV'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderDTOToJson(OrderDTO instance) => <String, dynamic>{
      'user': instance.user,
      'orderItems': instance.orderItems,
      'totalPrice': instance.totalPrice,
      'paymentType': instance.paymentType,
      'isPaid': instance.isPaid,
      'isDelivered': instance.isDelivered,
      'state': instance.state,
      'sId': instance.sId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'orderNumber': instance.orderNumber,
      'iV': instance.iV,
    };
