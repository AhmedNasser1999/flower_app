class CheckoutEntity {
  final String id;
  final int amountTotal;
  final int amountSubtotal;
  final String currency;
  final String? customerEmail;
  final String status;
  final String paymentStatus;
  final String cancelUrl;
  final String successUrl;
  final String? city;
  final String? street;
  final String? phone;
  final String? lat;
  final String? long;
  final String url;

  CheckoutEntity({
    required this.id,
    required this.amountTotal,
    required this.amountSubtotal,
    required this.currency,
    required this.customerEmail,
    required this.status,
    required this.paymentStatus,
    required this.cancelUrl,
    required this.successUrl,
    required this.city,
    required this.street,
    required this.phone,
    required this.lat,
    required this.long,
    required this.url,
  });
}
