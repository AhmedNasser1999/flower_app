import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/features/address/api/data_source_impl/address_remote_data_source_impl.dart';
import 'package:flower_app/features/address/domain/requests/address_request.dart';
import 'package:flower_app/features/address/domain/responses/address_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'address_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockAddressApiClient;
  late AddressRemoteDataSourceImpl dataSource;

  setUp(() {
    mockAddressApiClient = MockApiClient();
    dataSource =
        AddressRemoteDataSourceImpl(addressApiClient: mockAddressApiClient);
  });

  group('AddressRemoteDataSourceImpl', () {
    final mockAddressRequest = AddressRequest(
      street: '123 Main St',
      phone: '0123456789',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      recipientName: 'John Doe',
      area: 'Downtown',
    );

    final mockAddressResponse = AddressResponse(
      message: 'Success',
      addresses: [],
    );

    test('addAddress returns AddressResponse on success', () async {
      // Arrange
      when(mockAddressApiClient.addAddress(mockAddressRequest))
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result = await dataSource.addAddress(mockAddressRequest);

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Success');
      verify(mockAddressApiClient.addAddress(mockAddressRequest)).called(1);
    });

    test('addAddress throws exception when API fails with DioException',
        () async {
      // Arrange
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 500,
          data: {'error': 'Server error'},
        ),
      );

      when(mockAddressApiClient.addAddress(mockAddressRequest))
          .thenThrow(dioException);

      // Act
      final call = dataSource.addAddress;

      // Assert
      expect(() => call(mockAddressRequest), throwsA(isA<Exception>()));
      verify(mockAddressApiClient.addAddress(mockAddressRequest)).called(1);
    });

    test('getAddresses returns AddressResponse on success', () async {
      // Arrange
      when(mockAddressApiClient.getAddresses())
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result = await dataSource.getAddresses();

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Success');
      verify(mockAddressApiClient.getAddresses()).called(1);
    });

    test('getAddresses throws exception when API fails', () async {
      // Arrange
      when(mockAddressApiClient.getAddresses())
          .thenThrow(Exception('Network error'));

      // Act
      final call = dataSource.getAddresses;

      // Assert
      expect(() => call(), throwsA(isA<Exception>()));
      verify(mockAddressApiClient.getAddresses()).called(1);
    });

    test('updateAddress returns AddressResponse on success', () async {
      // Arrange
      const addressId = '123';
      when(mockAddressApiClient.updateAddress(addressId, mockAddressRequest))
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result =
          await dataSource.updateAddress(addressId, mockAddressRequest);

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Success');
      verify(mockAddressApiClient.updateAddress(addressId, mockAddressRequest))
          .called(1);
    });

    test('deleteAddress returns AddressResponse on success', () async {
      // Arrange
      const addressId = '123';
      when(mockAddressApiClient.deleteAddress(addressId))
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result = await dataSource.deleteAddress(addressId);

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Success');
      verify(mockAddressApiClient.deleteAddress(addressId)).called(1);
    });
  });
}
