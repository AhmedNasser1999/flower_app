import 'package:json_annotation/json_annotation.dart';
import 'adaptive_pricing.dart';
import 'automatic_tax.dart';
import 'collected_information.dart';
import 'custom_text.dart';
import 'customer_details.dart';
import 'invoice_creation.dart';
import 'payment_method_configuration_details.dart';
import 'payment_method_options.dart';
import 'session_metadata.dart';
import 'totail_details.dart';
part 'session.g.dart';

@JsonSerializable(explicitToJson: true)
class Session {
  final String? id;
  final String? object;
  @JsonKey(name: "adaptive_pricing")
  final AdaptivePricing? adaptivePricing;
  @JsonKey(name: "after_expiration")
  final dynamic afterExpiration;
  @JsonKey(name: "allow_promotion_codes")
  final dynamic allowPromotionCodes;
  @JsonKey(name: "amount_subtotal")
  final int? amountSubtotal;
  @JsonKey(name: "amount_total")
  final int? amountTotal;
  @JsonKey(name: "automatic_tax")
  final AutomaticTax? automaticTax;
  @JsonKey(name: "billing_address_collection")
  final dynamic billingAddressCollection;
  @JsonKey(name: "cancel_url")
  final String? cancelUrl;
  @JsonKey(name: "client_reference_id")
  final String? clientReferenceId;
  @JsonKey(name: "client_secret")
  final dynamic clientSecret;
  @JsonKey(name: "collected_information")
  final CollectedInformation? collectedInformation;
  final dynamic consent;
  @JsonKey(name: "consent_collection")
  final dynamic consentCollection;
  final int? created;
  final String? currency;
  @JsonKey(name: "currency_conversion")
  final dynamic currencyConversion;
  @JsonKey(name: "custom_fields")
  final List<dynamic> customFields;
  @JsonKey(name: "custom_text")
  final CustomText? customText;
  final dynamic customer;
  @JsonKey(name: "customer_creation")
  final String? customerCreation;
  @JsonKey(name: "customer_details")
  final CustomerDetails? customerDetails;
  @JsonKey(name: "customer_email")
  final String? customerEmail;
  final List<dynamic> discounts;
  @JsonKey(name: "expires_at")
  final int? expiresAt;
  final dynamic invoice;
  @JsonKey(name: "invoice_creation")
  final InvoiceCreation? invoiceCreation;
  final bool? livemode;
  final dynamic locale;
  final SessionMetadata? metadata;
  final String? mode;
  @JsonKey(name: "origin_context")
  final dynamic originContext;
  @JsonKey(name: "payment_intent")
  final dynamic paymentIntent;
  @JsonKey(name: "payment_link")
  final dynamic paymentLink;
  @JsonKey(name: "payment_method_collection")
  final String? paymentMethodCollection;
  @JsonKey(name: "payment_method_configuration_details")
  final PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails;
  @JsonKey(name: "payment_method_options")
  final PaymentMethodOptions? paymentMethodOptions;
  @JsonKey(name: "payment_method_types")
  final List<String> paymentMethodTypes;
  @JsonKey(name: "payment_status")
  final String? paymentStatus;
  final dynamic permissions;
  @JsonKey(name: "phone_number_collection")
  final AdaptivePricing? phoneNumberCollection;
  @JsonKey(name: "recovered_from")
  final dynamic recoveredFrom;
  @JsonKey(name: "saved_payment_method_options")
  final dynamic savedPaymentMethodOptions;
  @JsonKey(name: "setup_intent")
  final dynamic setupIntent;
  @JsonKey(name: "shipping_address_collection")
  final dynamic shippingAddressCollection;
  @JsonKey(name: "shipping_cost")
  final dynamic shippingCost;
  @JsonKey(name: "shipping_details")
  final dynamic shippingDetails;
  @JsonKey(name: "shipping_options")
  final List<dynamic> shippingOptions;
  final String? status;
  @JsonKey(name: "submit_type")
  final dynamic submitType;
  final dynamic subscription;
  @JsonKey(name: "success_url")
  final String? successUrl;
  @JsonKey(name: "total_details")
  final TotalDetails? totalDetails;
  @JsonKey(name: "ui_mode")
  final String? uiMode;
  final String? url;
  @JsonKey(name: "wallet_options")
  final dynamic walletOptions;

  Session({
    this.id,
    this.object,
    this.adaptivePricing,
    this.afterExpiration,
    this.allowPromotionCodes,
    this.amountSubtotal,
    this.amountTotal,
    this.automaticTax,
    this.billingAddressCollection,
    this.cancelUrl,
    this.clientReferenceId,
    this.clientSecret,
    this.collectedInformation,
    this.consent,
    this.consentCollection,
    this.created,
    this.currency,
    this.currencyConversion,
    this.customFields = const [],
    this.customText,
    this.customer,
    this.customerCreation,
    this.customerDetails,
    this.customerEmail,
    this.discounts = const [],
    this.expiresAt,
    this.invoice,
    this.invoiceCreation,
    this.livemode,
    this.locale,
    this.metadata,
    this.mode,
    this.originContext,
    this.paymentIntent,
    this.paymentLink,
    this.paymentMethodCollection,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    this.paymentMethodTypes = const [],
    this.paymentStatus,
    this.permissions,
    this.phoneNumberCollection,
    this.recoveredFrom,
    this.savedPaymentMethodOptions,
    this.setupIntent,
    this.shippingAddressCollection,
    this.shippingCost,
    this.shippingDetails,
    this.shippingOptions = const [],
    this.status,
    this.submitType,
    this.subscription,
    this.successUrl,
    this.totalDetails,
    this.uiMode,
    this.url,
    this.walletOptions,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
