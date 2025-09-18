// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodOptions _$PaymentMethodOptionsFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodOptions(
      card: json['card'] == null
          ? null
          : Card.fromJson(json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentMethodOptionsToJson(
        PaymentMethodOptions instance) =>
    <String, dynamic>{
      'card': instance.card?.toJson(),
    };
