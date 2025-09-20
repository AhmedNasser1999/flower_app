import 'package:flower_app/features/order/data/models/order_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api/api_client.dart';
import '../../data/data_sources/order_remote_data_source.dart';

@LazySingleton(as: OrderRemoteDataSource)
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiClient orderApiClient;

  OrderRemoteDataSourceImpl(this.orderApiClient);

  @override
  Future<OrderResponse> getOrders() async {
    return await orderApiClient.getOrders();
  }
}
