// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as String? ?? '',
      object: json['object'] as String? ?? '',
      afterExpiration: json['after_expiration'],
      allowPromotionCodes: json['allow_promotion_codes'],
      amountSubtotal: (json['amount_subtotal'] as num?)?.toInt() ?? 0,
      amountTotal: (json['amount_total'] as num?)?.toInt() ?? 0,
      billingAddressCollection: json['billing_address_collection'],
      cancelUrl: json['cancel_url'] as String? ?? '',
      clientReferenceId: json['client_reference_id'] as String? ?? '',
      clientSecret: json['client_secret'],
      consent: json['consent'],
      consentCollection: json['consent_collection'],
      created: (json['created'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? '',
      currencyConversion: json['currency_conversion'],
      customFields: json['custom_fields'] as List<dynamic>? ?? const [],
      customer: json['customer'],
      customerCreation: json['customer_creation'] as String? ?? '',
      customerDetails: json['customer_details'] == null
          ? null
          : CustomerDetails.fromJson(
              json['customer_details'] as Map<String, dynamic>),
      customerEmail: json['customer_email'] as String? ?? '',
      discounts: json['discounts'] as List<dynamic>? ?? const [],
      expiresAt: (json['expires_at'] as num?)?.toInt() ?? 0,
      invoice: json['invoice'],
      livemode: json['livemode'] as bool? ?? false,
      locale: json['locale'],
      metadata: json['metadata'] == null
          ? null
          : SessionMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      mode: json['mode'] as String? ?? '',
      originContext: json['origin_context'],
      paymentIntent: json['payment_intent'],
      paymentLink: json['payment_link'],
      paymentMethodCollection:
          json['payment_method_collection'] as String? ?? '',
      paymentMethodConfigurationDetails:
          json['payment_method_configuration_details'] == null
              ? null
              : PaymentMethodConfigurationDetails.fromJson(
                  json['payment_method_configuration_details']
                      as Map<String, dynamic>),
      paymentMethodTypes: (json['payment_method_types'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      paymentStatus: json['payment_status'] as String? ?? '',
      permissions: json['permissions'],
      recoveredFrom: json['recovered_from'],
      savedPaymentMethodOptions: json['saved_payment_method_options'],
      setupIntent: json['setup_intent'],
      shippingAddressCollection: json['shipping_address_collection'],
      shippingCost: json['shipping_cost'],
      shippingDetails: json['shipping_details'],
      shippingOptions: json['shipping_options'] as List<dynamic>? ?? const [],
      status: json['status'] as String? ?? '',
      submitType: json['submit_type'],
      subscription: json['subscription'],
      successUrl: json['success_url'] as String? ?? '',
      totalDetails: json['total_details'] == null
          ? null
          : TotalDetails.fromJson(
              json['total_details'] as Map<String, dynamic>),
      uiMode: json['ui_mode'] as String? ?? '',
      url: json['url'] as String? ?? '',
      walletOptions: json['wallet_options'],
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'after_expiration': instance.afterExpiration,
      'allow_promotion_codes': instance.allowPromotionCodes,
      'amount_subtotal': instance.amountSubtotal,
      'amount_total': instance.amountTotal,
      'billing_address_collection': instance.billingAddressCollection,
      'cancel_url': instance.cancelUrl,
      'client_reference_id': instance.clientReferenceId,
      'client_secret': instance.clientSecret,
      'consent': instance.consent,
      'consent_collection': instance.consentCollection,
      'created': instance.created,
      'currency': instance.currency,
      'currency_conversion': instance.currencyConversion,
      'custom_fields': instance.customFields,
      'customer': instance.customer,
      'customer_creation': instance.customerCreation,
      'customer_details': instance.customerDetails?.toJson(),
      'customer_email': instance.customerEmail,
      'discounts': instance.discounts,
      'expires_at': instance.expiresAt,
      'invoice': instance.invoice,
      'livemode': instance.livemode,
      'locale': instance.locale,
      'metadata': instance.metadata?.toJson(),
      'mode': instance.mode,
      'origin_context': instance.originContext,
      'payment_intent': instance.paymentIntent,
      'payment_link': instance.paymentLink,
      'payment_method_collection': instance.paymentMethodCollection,
      'payment_method_configuration_details':
          instance.paymentMethodConfigurationDetails?.toJson(),
      'payment_method_types': instance.paymentMethodTypes,
      'payment_status': instance.paymentStatus,
      'permissions': instance.permissions,
      'recovered_from': instance.recoveredFrom,
      'saved_payment_method_options': instance.savedPaymentMethodOptions,
      'setup_intent': instance.setupIntent,
      'shipping_address_collection': instance.shippingAddressCollection,
      'shipping_cost': instance.shippingCost,
      'shipping_details': instance.shippingDetails,
      'shipping_options': instance.shippingOptions,
      'status': instance.status,
      'submit_type': instance.submitType,
      'subscription': instance.subscription,
      'success_url': instance.successUrl,
      'total_details': instance.totalDetails?.toJson(),
      'ui_mode': instance.uiMode,
      'url': instance.url,
      'wallet_options': instance.walletOptions,
    };
