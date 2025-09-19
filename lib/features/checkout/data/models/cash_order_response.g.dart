// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashOrderResponse _$CashOrderResponseFromJson(Map<String, dynamic> json) =>
    CashOrderResponse(
      message: json['message'] as String?,
      order: json['order'] == null
          ? null
          : OrderDTO.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CashOrderResponseToJson(CashOrderResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'order': instance.order,
    };
