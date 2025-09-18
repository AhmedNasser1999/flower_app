import 'package:flower_app/features/checkout/data/models/cash_order_request.dart';
import 'package:flower_app/features/checkout/data/models/checkout_request.dart';
import 'package:flower_app/features/checkout/domain/entities/cash_order_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/checkout_entity.dart';

abstract class CheckoutRepo {
  Future<CashOrderEntity> createCashOrder(CashOrderRequest request);

  Future<CheckoutEntity> checkoutSession(CheckoutRequest request);
}
