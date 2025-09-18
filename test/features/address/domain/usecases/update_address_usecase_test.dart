import 'package:flower_app/features/address/domain/repositories/address_repository.dart';
import 'package:flower_app/features/address/domain/requests/address_request.dart';
import 'package:flower_app/features/address/domain/responses/address_response.dart';
import 'package:flower_app/features/address/domain/use_cases/address_use_cases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'update_address_usecase_test.mocks.dart';

@GenerateMocks([AddressRepository])
void main() {
  late MockAddressRepository mockRepository;
  late UpdateAddressUseCase useCase;

  setUp(() {
    mockRepository = MockAddressRepository();
    useCase = UpdateAddressUseCase(repository: mockRepository);
  });

  group('UpdateAddressUseCase', () {
    const addressId = '123';
    final mockAddressRequest = AddressRequest(
      street: '456 Updated St',
      phone: '0987654321',
      city: 'Alexandria',
      lat: '31.2001',
      long: '29.9187',
      recipientName: 'Jane Doe',
      area: 'New Area',
    );

    final mockAddressResponse = AddressResponse(
      message: 'Address updated successfully',
      addresses: [],
    );

    test('should return AddressResponse when repository succeeds', () async {
      // Arrange
      when(mockRepository.updateAddress(addressId, mockAddressRequest))
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result =
          await mockRepository.updateAddress(addressId, mockAddressRequest);

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Address updated successfully');
      verify(mockRepository.updateAddress(addressId, mockAddressRequest))
          .called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.updateAddress(addressId, mockAddressRequest))
          .thenThrow(Exception('Repository error'));

      // Act
      final call = useCase.execute;

      // Assert
      expect(
          () => call(addressId, mockAddressRequest), throwsA(isA<Exception>()));
      verify(mockRepository.updateAddress(addressId, mockAddressRequest))
          .called(1);
    });
  });
}
