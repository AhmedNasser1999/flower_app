import 'package:injectable/injectable.dart' hide Order;
import '../../domain/repositories/order_repository.dart';
import '../../domain/entities/order.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/order_model.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Order?> getOrderById({required String userId, required String orderId}) async {
    final model = await remoteDataSource.getOrderById(userId: userId, orderId: orderId);
    return model?.toEntity();
  }

  @override
  Stream<Order?> watchOrderById({required String userId, required String orderId}) {
    return remoteDataSource.watchOrderById(userId: userId, orderId: orderId)
      .map((model) => model?.toEntity());
  }
}
