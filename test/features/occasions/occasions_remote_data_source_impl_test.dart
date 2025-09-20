// test/features/occasion/data/datasource/occasion_remote_data_source_impl_test.dart
import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/features/occasion/api/datasource_impl/occasion_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_app/features/occasion/api/client/occasion_api_client.dart';
import 'package:flower_app/features/occasion/data/models/occasion_response_model.dart';
import 'package:flower_app/features/occasion/data/models/occasion_model.dart';

import 'occasion_api_client_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late OccasionRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = OccasionRemoteDataSourceImpl(mockApiClient);
  });

  group('getOccasions', () {
    test('should return OccasionsResponse when API call is successful',
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
          )
        ],
      );

      when(mockApiClient.getOccasions(page: 1, limit: 10))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await dataSource.getOccasions(page: 1, limit: 10);

      // Assert
      expect(result, equals(mockResponse));
      verify(mockApiClient.getOccasions(page: 1, limit: 10)).called(1);
    });

    test('should throw Exception when API call fails', () async {
      // Arrange
      when(mockApiClient.getOccasions()).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/occasions'),
        type: DioExceptionType.badResponse,
      ));

      // Act & Assert
      expect(
        () => dataSource.getOccasions(),
        throwsA(isA<Exception>()),
      );
      verify(mockApiClient.getOccasions()).called(1);
    });
  });
}
