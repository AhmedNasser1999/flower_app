// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDetails _$CustomerDetailsFromJson(Map<String, dynamic> json) =>
    CustomerDetails(
      address: json['address'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      taxExempt: json['tax_exempt'] as String?,
      taxIds:
          (json['tax_ids'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CustomerDetailsToJson(CustomerDetails instance) =>
    <String, dynamic>{
      'address': instance.address,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'tax_exempt': instance.taxExempt,
      'tax_ids': instance.taxIds,
    };
