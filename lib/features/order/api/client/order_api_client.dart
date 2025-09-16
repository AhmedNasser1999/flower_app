import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../data/models/order_response.dart';

part 'order_api_client.g.dart';

@injectable
@RestApi()
abstract class OrderApiClient {
  @factoryMethod
  factory OrderApiClient(Dio dio, {@Named("baseurl") String? baseUrl}) =
      _OrderApiClient;

  @GET("orders")
  @Extra({'auth': true})
  Future<OrderResponse> getOrders();
}
