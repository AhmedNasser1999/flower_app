
import 'package:flower_app/features/order/data/models/order_response.dart';
import 'package:injectable/injectable.dart';

import '../../data/data_sources/order_remote_data_source.dart';
import '../client/order_api_client.dart';

@LazySingleton(as: OrderRemoteDataSource)
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final OrderApiClient orderApiClient;

  OrderRemoteDataSourceImpl(this.orderApiClient);

  @override
  Future<OrderResponse> getOrders() async{
    return await orderApiClient.getOrders();
  }

}