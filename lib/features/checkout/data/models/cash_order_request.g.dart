// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashOrderRequest _$CashOrderRequestFromJson(Map<String, dynamic> json) =>
    CashOrderRequest(
      shippingAddress: json['shippingAddress'] == null
          ? null
          : CashOrderRequestDTO.fromJson(
              json['shippingAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CashOrderRequestToJson(CashOrderRequest instance) =>
    <String, dynamic>{
      'shippingAddress': instance.shippingAddress,
    };
