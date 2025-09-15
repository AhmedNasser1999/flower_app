// lib/features/order/data/repositories/order_repo_impl.dart
import 'package:injectable/injectable.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_item_entity.dart';
import '../../domain/repositories/order_repo.dart';
import '../data_sources/order_remote_data_source.dart';
import '../models/order_response.dart';

@LazySingleton(as: OrderRepo)
class OrderRepoImpl implements OrderRepo {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepoImpl(this._remoteDataSource);

  @override
  Future<List<OrderEntity>> getOrders() async {
    final OrderResponse response = await _remoteDataSource.getOrders();

    return response.orders.map((order) {
      return OrderEntity(
        id: order.id,
        orderNumber: order.orderNumber,
        totalPrice: order.totalPrice.toDouble(),
        state: order.state,
        createdAt: DateTime.parse(order.createdAt),
        orderItems: order.orderItems.map((item) {
          final product = item.product;
          return OrderItemEntity(
            productId: product.id,
            title: product.title,
            imgCover: product.imgCover,
            price: item.price.toDouble(),
            quantity: item.quantity,
          );
        }).toList(),
      );
    }).toList();
  }
}
