import 'package:flower_app/features/address/domain/repositories/address_repository.dart';
import 'package:flower_app/features/address/domain/responses/address_response.dart';
import 'package:flower_app/features/address/domain/use_cases/address_use_cases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'get_addresses_usecase_test.mocks.dart';

@GenerateMocks([AddressRepository])
void main() {
  late MockAddressRepository mockRepository;
  late GetAddressesUseCase useCase;

  setUp(() {
    mockRepository = MockAddressRepository();
    useCase = GetAddressesUseCase(repository: mockRepository);
  });

  group('GetAddressesUseCase', () {
    final mockAddressResponse = AddressResponse(
      message: 'Addresses retrieved successfully',
      addresses: [],
    );

    test('should return AddressResponse when repository succeeds', () async {
      // Arrange
      when(mockRepository.getAddresses())
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result = await mockRepository.getAddresses();

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Addresses retrieved successfully');
      verify(mockRepository.getAddresses()).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.getAddresses())
          .thenThrow(Exception('Repository error'));

      // Act
      final call = useCase;

      // Assert
      expect(() => call, throwsA(isA<Exception>()));
      verify(mockRepository.getAddresses()).called(1);
    });
  });
}