import 'package:dio/dio.dart';
import 'package:flower_app/core/contants/api_constants.dart';
import 'package:flower_app/features/checkout/data/models/cash_order_request.dart';
import 'package:flower_app/features/checkout/data/models/cash_order_response.dart';
import 'package:flower_app/features/checkout/data/models/chechout_response.dart';
import 'package:flower_app/features/checkout/data/models/checkout_request.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(ApiConstant.cashOrder)
  Future<CashOrderResponse> createCashOrder(
      @Body() CashOrderRequest cashOrderRequest);

  @POST(ApiConstant.checkout)
  Future<CheckoutResponse> checkoutSession(
      @Body() CheckoutRequest checkoutRequest);
}
