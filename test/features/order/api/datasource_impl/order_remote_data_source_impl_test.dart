import 'package:flower_app/features/order/api/data_source_impl/order_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/features/order/data/models/order_response.dart';
import 'package:flower_app/features/order/data/models/order_model.dart';
import 'package:flower_app/features/order/api/client/order_api_client.dart';

import 'order_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([OrderApiClient])
void main() {
  late MockOrderApiClient mockOrderApiClient;
  late OrderRemoteDataSourceImpl dataSource;

  setUp(() {
    mockOrderApiClient = MockOrderApiClient();
    dataSource = OrderRemoteDataSourceImpl(mockOrderApiClient);
  });

  group('OrderRemoteDataSourceImpl', () {
    test('should return OrderResponse when API call is successful', () async {
      // arrange
      final fakeResponse = OrderResponse(
        message: '',
        orders: [
          OrderModel(
            "2025-09-13T12:00:00Z",
            id: "1",
            orderNumber: "ORD-1001",
            totalPrice: 200.0,
            state: "Active",
            orderItems: [],
          ),
          OrderModel(
            "2025-09-13T12:30:00Z",
            id: "2",
            orderNumber: "ORD-1002",
            totalPrice: 300.0,
            state: "Completed",
            orderItems: [],
          ),
        ],
      );

      when(mockOrderApiClient.getOrders())
          .thenAnswer((_) async => fakeResponse);

      // act
      final result = await dataSource.getOrders();

      // assert
      expect(result.orders.length, 2);
      expect(result.orders.first.state, "Active");
      verify(mockOrderApiClient.getOrders()).called(1);
    });

    test('should throw Exception when API fails', () async {
      // arrange
      when(mockOrderApiClient.getOrders()).thenThrow(Exception("API error"));

      // act
      final call = dataSource.getOrders;

      // assert
      expect(() => call(), throwsA(isA<Exception>()));
      verify(mockOrderApiClient.getOrders()).called(1);
    });
  });
}
