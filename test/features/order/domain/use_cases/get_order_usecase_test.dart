import 'package:flower_app/features/order/domain/use_cases/get_orders_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/order/domain/repositories/order_repo.dart';
import 'package:flower_app/features/order/domain/entities/order_entity.dart';
import 'package:flower_app/features/order/domain/entities/order_item_entity.dart';

import 'get_order_usecase_test.mocks.dart';

@GenerateMocks([OrderRepo])
void main() {
  late MockOrderRepo mockOrderRepo;
  late GetOrdersUseCase useCase;

  setUp(() {
    mockOrderRepo = MockOrderRepo();
    useCase = GetOrdersUseCase(mockOrderRepo);
  });

  group('GetOrdersUseCase', () {
    test('should return List<OrderEntity> when repo call is successful',
        () async {
      // arrange
      final fakeOrders = [
        OrderEntity(
          id: "1",
          orderNumber: "ORD-1001",
          totalPrice: 250.0,
          state: "Active",
          createdAt: DateTime.parse("2025-09-13T12:00:00Z"),
          orderItems: [
            OrderItemEntity(
              productId: "P1",
              title: "Red Roses",
              imgCover: "rose.jpg",
              price: 50.0,
              quantity: 5,
            ),
          ],
        ),
      ];

      when(mockOrderRepo.getOrders()).thenAnswer((_) async => fakeOrders);

      // act
      final result = await useCase();

      // assert
      expect(result, fakeOrders);
      verify(mockOrderRepo.getOrders()).called(1);
    });

    test('should throw Exception when repo call fails', () async {
      // arrange
      when(mockOrderRepo.getOrders()).thenThrow(Exception("Repo error"));

      // act
      final call = useCase;

      // assert
      expect(() => call(), throwsA(isA<Exception>()));
      verify(mockOrderRepo.getOrders()).called(1);
    });
  });
}
