// test/features/occasion/data/repositories/occasion_repository_impl_test.dart
import 'package:flower_app/features/occasion/data/repositories_impl/occasion_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_app/features/occasion/data/datasource/occasion_remote_data_source.dart';
import 'package:flower_app/features/occasion/data/models/occasion_response_model.dart';
import 'package:flower_app/features/occasion/data/models/occasion_model.dart';
import 'package:flower_app/features/occasion/domain/entity/occasion_entity.dart';

import 'occasion_repo_impl_test.mocks.dart';

@GenerateMocks([OccasionRemoteDataSource]) // Add this annotation
void main() {
  late MockOccasionRemoteDataSource
      mockRemoteDataSource; // Use the generated mock
  late OccasionRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockOccasionRemoteDataSource();
    repository = OccasionRepositoryImpl(mockRemoteDataSource);
  });

  group('getOccasions', () {
    test('should return list of OccasionEntity when remote call is successful',
        () async {
      // Arrange
      final mockResponse = OccasionsResponse(
        message: "success",
        metadata: Metadata(
          currentPage: 1,
          limit: 10,
          totalPages: 1,
          totalItems: 2,
        ),
        occasions: [
          OccasionModel(
            id: "1",
            name: "Birthday",
            slug: "birthday",
            image: "https://example.com/birthday.png",
            createdAt: "2024-08-01",
            updatedAt: "2024-08-10",
            isSuperAdmin: false,
            productsCount: 5,
          ),
          OccasionModel(
            id: "2",
            name: "Wedding",
            slug: "wedding",
            image: "https://example.com/wedding.png",
            createdAt: "2024-08-02",
            updatedAt: "2024-08-11",
            isSuperAdmin: false,
            productsCount: 8,
          )
        ],
      );

      when(mockRemoteDataSource.getOccasions(page: 1, limit: 10))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.getOccasions(page: 1, limit: 10);

      // Assert
      expect(result, isA<List<OccasionEntity>>());
      expect(result.length, equals(2));
      expect(result[0].name, equals("Birthday"));
      expect(result[1].name, equals("Wedding"));
      verify(mockRemoteDataSource.getOccasions(page: 1, limit: 10)).called(1);
    });

    test('should throw Exception when remote call fails', () async {
      // Arrange
      when(mockRemoteDataSource.getOccasions())
          .thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () => repository.getOccasions(),
        throwsA(isA<Exception>()),
      );
      verify(mockRemoteDataSource.getOccasions()).called(1);
    });
  });
}
