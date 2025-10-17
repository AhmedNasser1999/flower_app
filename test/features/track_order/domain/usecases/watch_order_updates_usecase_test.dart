import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/track_order/domain/usecases/watch_order_updates_usecase.dart';
import 'package:flower_app/features/track_order/domain/entities/order.dart';
import 'package:flower_app/features/track_order/domain/repositories/order_repository.dart';

import 'watch_order_updates_usecase_test.mocks.dart';

@GenerateMocks([OrderRepository])
void main() {
  late MockOrderRepository mockRepo;
  late WatchOrderUpdatesUseCase useCase;

  setUp(() {
    mockRepo = MockOrderRepository();
    useCase = WatchOrderUpdatesUseCase(mockRepo);
  });
  final order = Order(
    id: 'id',
    arrivedAtPickup: false,
    createdAt: 1,
    driverId: '',
    items: [],
    lastUpdated: 1,
    orderNumber: '',
    paymentMethod: '',
    pickupAddress: PickupAddress(address: '', name: '', phoneNumber: ''),
    state: '',
    total: 0,
    updateOrderButton: '',
    userAddress: UserAddress(address: '', name: '', phoneNumber: ''),
  );

  test('emits order from repo', () async {
    when(mockRepo.watchOrderById(userId: anyNamed('userId'), orderId: anyNamed('orderId'))) 
      .thenAnswer((_) => Stream.value(order));
    final result = useCase(userId: 'u', orderId: 'o');
    expectLater(result, emits(order));
  });

  test('emits null from repo', () async {
    when(mockRepo.watchOrderById(userId: anyNamed('userId'), orderId: anyNamed('orderId'))) 
      .thenAnswer((_) => Stream.value(null));
    final result = useCase(userId: 'u', orderId: 'o');
    expectLater(result, emits(isNull));
  });
}

