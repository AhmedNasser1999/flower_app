import 'package:flower_app/features/address/data/data_source/address_remote_data_source.dart';
import 'package:flower_app/features/address/data/repo_impl/address_repo_impl.dart';
import 'package:flower_app/features/address/domain/requests/address_request.dart';
import 'package:flower_app/features/address/domain/responses/address_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'address_repo_impl_test.mocks.dart';

@GenerateMocks([AddressRemoteDataSource])
void main() {
  late MockAddressRemoteDataSource mockDataSource;
  late AddressRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockAddressRemoteDataSource();
    repository = AddressRepositoryImpl(remoteDataSource: mockDataSource);
  });

  group('AddressRepositoryImpl', () {
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

    test('addAddress returns AddressResponse when data source succeeds',
        () async {
      // Arrange
      when(mockDataSource.addAddress(mockAddressRequest))
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result = await repository.addAddress(mockAddressRequest);

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Success');
      verify(mockDataSource.addAddress(mockAddressRequest)).called(1);
    });

    test('addAddress throws exception when data source fails', () async {
      // Arrange
      when(mockDataSource.addAddress(mockAddressRequest))
          .thenThrow(Exception('API Error'));

      // Act
      final call = repository.addAddress;

      // Assert
      expect(() => call(mockAddressRequest), throwsA(isA<Exception>()));
      verify(mockDataSource.addAddress(mockAddressRequest)).called(1);
    });

    test('getAddresses returns AddressResponse when data source succeeds',
        () async {
      // Arrange
      when(mockDataSource.getAddresses())
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result = await repository.getAddresses();

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Success');
      verify(mockDataSource.getAddresses()).called(1);
    });

    test('updateAddress returns AddressResponse when data source succeeds',
        () async {
      // Arrange
      const addressId = '123';
      when(mockDataSource.updateAddress(addressId, mockAddressRequest))
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result =
          await repository.updateAddress(addressId, mockAddressRequest);

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Success');
      verify(mockDataSource.updateAddress(addressId, mockAddressRequest))
          .called(1);
    });

    test('deleteAddress returns AddressResponse when data source succeeds',
        () async {
      // Arrange
      const addressId = '123';
      when(mockDataSource.deleteAddress(addressId))
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result = await repository.deleteAddress(addressId);

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Success');
      verify(mockDataSource.deleteAddress(addressId)).called(1);
    });
  });
}
