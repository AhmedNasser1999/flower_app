// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'automatic_tax.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutomaticTax _$AutomaticTaxFromJson(Map<String, dynamic> json) => AutomaticTax(
      enabled: json['enabled'] as bool?,
      liability: json['liability'] as String?,
      provider: json['provider'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AutomaticTaxToJson(AutomaticTax instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'liability': instance.liability,
      'provider': instance.provider,
      'status': instance.status,
    };
