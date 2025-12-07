import 'package:flower_app/features/address/domain/repositories/address_repository.dart';
import 'package:flower_app/features/address/domain/responses/address_response.dart';
import 'package:flower_app/features/address/domain/use_cases/address_use_cases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'delete_address_usecase_test.mocks.dart';

@GenerateMocks([AddressRepository])
void main() {
  late MockAddressRepository mockRepository;
  late DeleteAddressUseCase useCase;

  setUp(() {
    mockRepository = MockAddressRepository();
    useCase = DeleteAddressUseCase(repository: mockRepository);
  });

  group('DeleteAddressUseCase', () {
    const addressId = '123';

    final mockAddressResponse = AddressResponse(
      message: 'Address deleted successfully',
      addresses: [],
    );

    test('should return AddressResponse when repository succeeds', () async {
      // Arrange
      when(mockRepository.deleteAddress(addressId))
          .thenAnswer((_) async => mockAddressResponse);

      // Act
      final result = await mockRepository.deleteAddress(addressId);

      // Assert
      expect(result, isA<AddressResponse>());
      expect(result.message, 'Address deleted successfully');
      verify(mockRepository.deleteAddress(addressId)).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.deleteAddress(addressId))
          .thenThrow(Exception('Repository error'));

      // Act
      final call = useCase.execute;

      // Assert
      expect(() => call(addressId), throwsA(isA<Exception>()));
      verify(mockRepository.deleteAddress(addressId)).called(1);
    });
  });
}
