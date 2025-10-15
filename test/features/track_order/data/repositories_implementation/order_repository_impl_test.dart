import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/track_order/data/repositories_implementation/order_repository_impl.dart';
import 'package:flower_app/features/track_order/data/models/order_model.dart';
import 'package:flower_app/features/track_order/data/datasources/order_remote_data_source.dart';
import 'package:flower_app/features/track_order/domain/entities/order.dart';

import 'order_repository_impl_test.mocks.dart';

@GenerateMocks([OrderRemoteDataSource, OrderModel])
void main() {
  late MockOrderRemoteDataSource mockDataSource;
  late OrderRepositoryImpl repo;

  setUp(() {
    mockDataSource = MockOrderRemoteDataSource();
    repo = OrderRepositoryImpl(mockDataSource);
  });

  final sampleModel = OrderModel(
    id: 'id',
    arrivedAtPickup: false,
    createdAt: 123,
    driverId: 'driver',
    items: [],
    lastUpdated: 0,
    orderNumber: 'NUM',
    paymentMethod: '',
    pickupAddress: PickupAddressModel(address: '', name: '', phoneNumber: ''),
    state: 'received',
    total: 87,
    updateOrderButton: 'received',
    userAddress: UserAddressModel(address: '', name: '', phoneNumber: ''),
  );

  test('getOrderById returns mapped entity for non-null model', () async {
    when(mockDataSource.getOrderById(userId: anyNamed('userId'), orderId: anyNamed('orderId')))
        .thenAnswer((_) async => sampleModel);
    final result = await repo.getOrderById(userId: 'u', orderId: 'o');
    expect(result, isA<Order>());
    expect(result?.id, 'id');
  });

  test('getOrderById returns null when dataSource returns null', () async {
    when(mockDataSource.getOrderById(userId: anyNamed('userId'), orderId: anyNamed('orderId')))
        .thenAnswer((_) async => null);
    final result = await repo.getOrderById(userId: 'u', orderId: 'o');
    expect(result, isNull);
  });
}
