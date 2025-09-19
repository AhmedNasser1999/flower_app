// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_order_request_DTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashOrderRequestDTO _$CashOrderRequestDTOFromJson(Map<String, dynamic> json) =>
    CashOrderRequestDTO(
      street: json['street'] as String?,
      phone: json['phone'] as String?,
      city: json['city'] as String?,
      lat: json['lat'] as String?,
      long: json['long'] as String?,
    );

Map<String, dynamic> _$CashOrderRequestDTOToJson(
        CashOrderRequestDTO instance) =>
    <String, dynamic>{
      'street': instance.street,
      'phone': instance.phone,
      'city': instance.city,
      'lat': instance.lat,
      'long': instance.long,
    };
