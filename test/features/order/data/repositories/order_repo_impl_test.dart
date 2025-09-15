import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/order/data/repositories/order_repo_impl.dart';
import 'package:flower_app/features/order/data/data_sources/order_remote_data_source.dart';
import 'package:flower_app/features/order/data/models/order_response.dart';
import 'package:flower_app/features/order/data/models/order_model.dart';
import 'package:flower_app/features/order/data/models/order_item_model.dart';
import 'package:flower_app/features/order/data/models/product_model.dart';
import 'package:flower_app/features/order/domain/entities/order_entity.dart';

import 'order_repo_impl_test.mocks.dart';

@GenerateMocks([OrderRemoteDataSource])
void main() {
  late MockOrderRemoteDataSource mockRemoteDataSource;
  late OrderRepoImpl repo;

  setUp(() {
    mockRemoteDataSource = MockOrderRemoteDataSource();
    repo = OrderRepoImpl(mockRemoteDataSource);
  });

  group('OrderRepoImpl', () {
    test('should map OrderResponse -> List<OrderEntity> correctly', () async {
      final fakeResponse = OrderResponse(
        message: 'success',
        orders: [
          OrderModel(
            "2025-09-13T12:00:00Z",
            id: "1",
            orderNumber: "ORD-1001",
            totalPrice: 250.0,
            state: "Active",
            orderItems: [
              OrderItemModel(
                id: "OI1",
                product: ProductModel(
                  id: "P1",
                  title: "Red Roses",
                  imgCover: "rose.jpg",
                  price: 50.0,
                  priceAfterDiscount: 40.0,
                ),
                price: 50.0,
                quantity: 5,
              ),
              OrderItemModel(
                id: "OI2",
                product: ProductModel(
                  id: "P2",
                  title: "White Lily",
                  imgCover: "lily.jpg",
                  price: 100.0,
                  priceAfterDiscount: null,
                ),
                price: 100.0,
                quantity: 1,
              ),
            ],
          ),
        ],
      );

      when(mockRemoteDataSource.getOrders())
          .thenAnswer((_) async => fakeResponse);

      // act
      final result = await repo.getOrders();

      // assert
      expect(result, isA<List<OrderEntity>>());
      expect(result.length, 1);

      final order = result.first;
      expect(order.id, "1");
      expect(order.orderNumber, "ORD-1001");
      expect(order.totalPrice, 250.0);
      expect(order.state, "Active");
      expect(order.createdAt, DateTime.parse("2025-09-13T12:00:00Z"));

      expect(order.orderItems.length, 2);
      expect(order.orderItems.first.productId, "P1");
      expect(order.orderItems.first.title, "Red Roses");
      expect(order.orderItems.first.imgCover, "rose.jpg");
      expect(order.orderItems.first.price, 50.0);
      expect(order.orderItems.first.quantity, 5);

      expect(order.orderItems[1].productId, "P2");
      expect(order.orderItems[1].title, "White Lily");

      verify(mockRemoteDataSource.getOrders()).called(1);
    });

    test('should throw Exception when datasource fails', () async {
      // arrange
      when(mockRemoteDataSource.getOrders()).thenThrow(Exception("API error"));

      // act
      final call = repo.getOrders;

      // assert
      expect(() => call(), throwsA(isA<Exception>()));
      verify(mockRemoteDataSource.getOrders()).called(1);
    });
  });
}
