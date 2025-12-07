import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel?> getOrderById({required String userId, required String orderId});
  Stream<OrderModel?> watchOrderById({required String userId, required String orderId});
}

@LazySingleton(as: OrderRemoteDataSource)
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;
  OrderRemoteDataSourceImpl(this.firestore);

  @override
  Future<OrderModel?> getOrderById({required String userId, required String orderId}) async {
    final doc = await firestore.collection('users').doc(userId).collection('orders').doc(orderId).get();
    if (doc.exists) {
      return OrderModel.fromFirestore(doc);
    }
    return null;
  }

  @override
  Stream<OrderModel?> watchOrderById({required String userId, required String orderId}) {
    return firestore
      .collection('users')
      .doc(userId)
      .collection('orders')
      .doc(orderId)
      .snapshots()
      .map((doc) => doc.exists ? OrderModel.fromFirestore(doc) : null);
  }
}
