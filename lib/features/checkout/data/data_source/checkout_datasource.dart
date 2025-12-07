import 'package:flower_app/features/checkout/data/models/cash_order_request.dart';
import 'package:flower_app/features/checkout/data/models/cash_order_response.dart';
import 'package:flower_app/features/checkout/data/models/chechout_response.dart';
import 'package:flower_app/features/checkout/data/models/checkout_request.dart';

abstract class CheckoutDatasource {
  Future<CashOrderResponse> createCashOrder(CashOrderRequest request);

  Future<CheckoutResponse> checkoutSession(CheckoutRequest request);
}
