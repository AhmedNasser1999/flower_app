
import '../models/order_response.dart';

abstract class OrderRemoteDataSource {
  Future<OrderResponse> getOrders();
}