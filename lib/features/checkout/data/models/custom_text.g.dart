// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomText _$CustomTextFromJson(Map<String, dynamic> json) => CustomText(
      afterSubmit: json['after_submit'] as String?,
      shippingAddress: json['shipping_address'] as String?,
      submit: json['submit'] as String?,
      termsOfServiceAcceptance: json['terms_of_service_acceptance'] as String?,
    );

Map<String, dynamic> _$CustomTextToJson(CustomText instance) =>
    <String, dynamic>{
      'after_submit': instance.afterSubmit,
      'shipping_address': instance.shippingAddress,
      'submit': instance.submit,
      'terms_of_service_acceptance': instance.termsOfServiceAcceptance,
    };
