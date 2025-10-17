import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/track_order/presentation/cubit/track_order_cubit.dart';
import 'package:flower_app/features/track_order/domain/usecases/get_order_by_id_usecase.dart';
import 'package:flower_app/features/track_order/domain/usecases/watch_order_updates_usecase.dart';
import 'package:flower_app/features/track_order/domain/entities/order.dart';
import 'package:flower_app/features/track_order/presentation/cubit/track_order_state.dart';

import 'track_order_cubit_test.mocks.dart';

@GenerateMocks([GetOrderByIdUseCase, WatchOrderUpdatesUseCase])
void main() {
  late TrackOrderCubit cubit;
  late MockGetOrderByIdUseCase mockGetOrderByIdUseCase;
  late MockWatchOrderUpdatesUseCase mockWatchOrderUpdatesUseCase;

  setUp(() {
    mockGetOrderByIdUseCase = MockGetOrderByIdUseCase();
    mockWatchOrderUpdatesUseCase = MockWatchOrderUpdatesUseCase();
    cubit = TrackOrderCubit(
      getOrderByIdUseCase: mockGetOrderByIdUseCase,
      watchOrderUpdatesUseCase: mockWatchOrderUpdatesUseCase,
    );
  });

  test('initial state is TrackOrderInitial', () {
    expect(cubit.state, isA<TrackOrderInitial>());
  });

  test('emits [Loading, Loaded] when getOrder returns order', () async {
    final order = Order(
      id: '1',
      arrivedAtPickup: false,
      createdAt: 123,
      driverId: 'driver',
      items: const [],
      lastUpdated: 0,
      orderNumber: 'ORD1',
      paymentMethod: '',
      pickupAddress: PickupAddress(address: '', name: '', phoneNumber: ''),
      state: 'received',
      total: 99,
      updateOrderButton: 'received',
      userAddress: UserAddress(address: '', name: '', phoneNumber: ''),
    );

    when(mockGetOrderByIdUseCase(userId: anyNamed('userId'), orderId: anyNamed('orderId'))) 
      .thenAnswer((_) async => order);

    expectLater(
      cubit.stream,
      emitsInOrder([
        isA<TrackOrderLoading>(),
        isA<TrackOrderLoaded>(),
      ]),
    );
    cubit.getOrder(userId: 'uid', orderId: 'oid');
  });

  test('emits [Loading, Error] when getOrder throws', () async {
    when(mockGetOrderByIdUseCase(userId: anyNamed('userId'), orderId: anyNamed('orderId'))) 
      .thenThrow(Exception('fail'));

    expectLater(
      cubit.stream,
      emitsInOrder([isA<TrackOrderLoading>(), isA<TrackOrderError>()]),
    );

    cubit.getOrder(userId: 'uid', orderId: 'oid');
  });
}

