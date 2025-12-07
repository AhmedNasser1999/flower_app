import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/track_order/domain/usecases/get_order_by_id_usecase.dart';
import 'package:flower_app/features/track_order/domain/entities/order.dart';
import 'package:flower_app/features/track_order/domain/repositories/order_repository.dart';

import 'get_order_by_id_usecase_test.mocks.dart';

@GenerateMocks([OrderRepository])
void main() {
  late MockOrderRepository mockRepo;
  late GetOrderByIdUseCase useCase;

  setUp(() {
    mockRepo = MockOrderRepository();
    useCase = GetOrderByIdUseCase(mockRepo);
  });

  final order = Order(
    id: 'id',
    arrivedAtPickup: false,
    createdAt: 111,
    driverId: 'd',
    items: [],
    lastUpdated: 0,
    orderNumber: '',
    paymentMethod: '',
    pickupAddress: PickupAddress(address: '', name: '', phoneNumber: ''),
    state: '',
    total: 0,
    updateOrderButton: '',
    userAddress: UserAddress(address: '', name: '', phoneNumber: ''),
  );

  test('returns order when repo returns value', () async {
    when(mockRepo.getOrderById(userId: anyNamed('userId'), orderId: anyNamed('orderId'))) 
      .thenAnswer((_) async => order);
    final result = await useCase(userId: 'uid', orderId: 'oid');
    expect(result, isA<Order>());
    expect(result?.id, 'id');
  });

  test('returns null when repo returns null', () async {
    when(mockRepo.getOrderById(userId: anyNamed('userId'), orderId: anyNamed('orderId')))
        .thenAnswer((_) async => null);
    final result = await useCase(userId: 'uid', orderId: 'oid');
    expect(result, isNull);
  });
}

