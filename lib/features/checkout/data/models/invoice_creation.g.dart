// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_creation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceCreation _$InvoiceCreationFromJson(Map<String, dynamic> json) =>
    InvoiceCreation(
      enabled: json['enabled'] as bool?,
      invoiceData: json['invoice_data'] == null
          ? null
          : InvoiceData.fromJson(json['invoice_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceCreationToJson(InvoiceCreation instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'invoice_data': instance.invoiceData?.toJson(),
    };
