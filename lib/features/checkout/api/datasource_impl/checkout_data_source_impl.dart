import 'package:flower_app/features/checkout/data/data_source/checkout_datasource.dart';
import 'package:flower_app/features/checkout/data/models/cash_order_request.dart';
import 'package:flower_app/features/checkout/data/models/cash_order_response.dart';
import 'package:flower_app/features/checkout/data/models/chechout_response.dart';
import 'package:flower_app/features/checkout/data/models/checkout_request.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';

@LazySingleton(as: CheckoutDatasource)
class CheckoutDataSourceImpl extends CheckoutDatasource {
  final ApiClient apiClient;
  CheckoutDataSourceImpl({required this.apiClient});
  @override
  Future<CheckoutResponse> checkoutSession(CheckoutRequest request) async {
    return await apiClient.checkoutSession(request);
  }

  @override
  Future<CashOrderResponse> createCashOrder(CashOrderRequest request) async {
    return await apiClient.createCashOrder(request);
  }
}
