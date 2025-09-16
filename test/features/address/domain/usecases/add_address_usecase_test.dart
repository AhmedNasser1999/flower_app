import 'package:flower_app/features/address/domain/repositories/address_repository.dart';
import 'package:flower_app/features/address/domain/requests/address_request.dart';
import 'package:flower_app/features/address/domain/responses/address_response.dart';
import 'package:flower_app/features/address/domain/use_cases/address_use_cases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'add_address_usecase_test.mocks.dart';

@GenerateMocks([AddressRepository])
void main() {
  late MockAddressRepository mockRepository;
  late AddAddressUseCase useCase;

  setUp(() {
    mockRepository = MockAddressRepository();
    useCase = AddAddressUseCase(repository: mockRepository);
  });

  group('AddAddressUseCase', () {
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
      message: 'Address added successfully',
      addresses: [],
    );

    test('should return AddressResponse when repository succeeds', () async {
      // Arrange
      when(mockRepository.addAddress(mockAddressRequest))
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result = await mockRepository.addAddress(mockAddressRequest);

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Address added successfully');
      verify(mockRepository.addAddress(mockAddressRequest)).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.addAddress(mockAddressRequest))
          .thenThrow(Exception('Repository error'));

      // Act
      final call = useCase.execute;

      // Assert
      expect(() => call(mockAddressRequest), throwsA(isA<Exception>()));
      verify(mockRepository.addAddress(mockAddressRequest)).called(1);
    });
  });
}
