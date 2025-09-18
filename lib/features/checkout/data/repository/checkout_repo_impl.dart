import 'package:flower_app/features/checkout/data/data_source/checkout_datasource.dart';
import 'package:flower_app/features/checkout/data/models/cash_order_request.dart';
import 'package:flower_app/features/checkout/data/models/checkout_request.dart';
import 'package:flower_app/features/checkout/domain/entities/cash_order_entity.dart';
import 'package:flower_app/features/checkout/domain/entities/checkout_entity.dart';
import 'package:flower_app/features/checkout/domain/repository/checkout_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CheckoutRepo)
class CheckoutRepoImpl extends CheckoutRepo {
  final CheckoutDatasource checkoutDatasource;

  CheckoutRepoImpl(this.checkoutDatasource);

  @override
  Future<CheckoutEntity> checkoutSession(CheckoutRequest request) async {
    final response = await checkoutDatasource.checkoutSession(request);
    return CheckoutEntity(
      id: response.session!.id!,
      amountTotal: response.session!.amountTotal!,
      amountSubtotal: response.session!.amountSubtotal!,
      currency: response.session!.currency!,
      customerEmail: response.session!.customerEmail ?? '',
      status: response.session!.status ?? '',
      paymentStatus: response.session!.paymentStatus ?? '',
      cancelUrl: response.session!.cancelUrl ?? '',
      successUrl: response.session!.successUrl ?? '',
      city: response.session!.metadata!.city!,
      street: response.session!.metadata!.street,
      phone: response.session!.metadata!.phone,
      lat: response.session!.metadata!.lat,
      long: response.session!.metadata!.long,
      url: response.session!.url ?? '',
    );
  }

  @override
  Future<CashOrderEntity> createCashOrder(CashOrderRequest request) async {
    final response = await checkoutDatasource.createCashOrder(request);
    return CashOrderEntity(
      totalPrice: response.order!.totalPrice!,
      paymentType: response.order!.paymentType!,
      isPaid: response.order!.isPaid!,
      isDelivered: response.order!.isDelivered!,
      state: response.order!.state!,
      createdAt: response.order!.createdAt!,
      updatedAt: response.order!.updatedAt!,
      orderNumber: response.order!.orderNumber!,
    );
  }
}
