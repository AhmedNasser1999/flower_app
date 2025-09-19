// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totail_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TotalDetails _$TotalDetailsFromJson(Map<String, dynamic> json) => TotalDetails(
      amountDiscount: (json['amount_discount'] as num).toInt(),
      amountShipping: (json['amount_shipping'] as num).toInt(),
      amountTax: (json['amount_tax'] as num).toInt(),
    );

Map<String, dynamic> _$TotalDetailsToJson(TotalDetails instance) =>
    <String, dynamic>{
      'amount_discount': instance.amountDiscount,
      'amount_shipping': instance.amountShipping,
      'amount_tax': instance.amountTax,
    };
