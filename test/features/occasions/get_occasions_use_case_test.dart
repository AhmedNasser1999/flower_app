// test/features/occasion/domain/usecases/get_occasions_use_case_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_app/features/occasion/domain/repositories/occasion_repository.dart';
import 'package:flower_app/features/occasion/domain/usecases/get_occasions_use_case.dart';
import 'package:flower_app/features/occasion/domain/entity/occasion_entity.dart';

import 'get_occasions_use_case_test.mocks.dart';

@GenerateMocks([OccasionRepository])
void main() {
  late MockOccasionRepository mockRepository;
  late GetOccasionsUseCase useCase;

  setUp(() {
    mockRepository = MockOccasionRepository();
    useCase = GetOccasionsUseCase(mockRepository);
  });

  group('call', () {
    test('should return list of OccasionEntity from repository', () async {
      // Arrange
      final expectedOccasions = [
        OccasionEntity(
          id: "1",
          name: "Birthday",
          slug: "birthday",
          image: "birthday.png",
          createdAt: "2024-01-01",
          updatedAt: "2024-01-02",
          isSuperAdmin: false,
          productsCount: 5,
        )
      ];

      when(mockRepository.getOccasions(page: 1, limit: 10))
          .thenAnswer((_) async => expectedOccasions);

      // Act
      final result = await useCase(page: 1, limit: 10);

      // Assert
      expect(result, equals(expectedOccasions));
      verify(mockRepository.getOccasions(page: 1, limit: 10)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should propagate exceptions from repository', () async {
      // Arrange
      when(mockRepository.getOccasions())
          .thenThrow(Exception('Repository error'));

      // Act & Assert
      expect(
            () => useCase(),
        throwsA(isA<Exception>()),
      );
      verify(mockRepository.getOccasions()).called(1);
    });

    test('should handle empty parameters', () async {
      // Arrange
      final expectedOccasions = [
        OccasionEntity(
          id: "1",
          name: "Birthday",
          slug: "birthday",
          image: "birthday.png",
          createdAt: "2024-01-01",
          updatedAt: "2024-01-02",
          isSuperAdmin: false,
          productsCount: 5,
        )
      ];

      when(mockRepository.getOccasions())
          .thenAnswer((_) async => expectedOccasions);

      // Act
      final result = await useCase();

      // Assert
      expect(result, equals(expectedOccasions));
      verify(mockRepository.getOccasions()).called(1);
    });
  });
}