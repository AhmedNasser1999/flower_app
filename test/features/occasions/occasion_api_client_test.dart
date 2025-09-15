// test/features/occasion/api/client/occasion_api_client_test.dart
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_app/features/occasion/api/client/occasion_api_client.dart';
import 'package:flower_app/features/occasion/data/models/occasion_response_model.dart';
import 'package:flower_app/features/occasion/data/models/occasion_model.dart';

import 'occasion_api_client_test.mocks.dart';


@GenerateMocks([OccasionApiClient])
void main() {
  late MockOccasionApiClient mockOccasionApiClient;

  setUp(() {
    mockOccasionApiClient = MockOccasionApiClient();
  });

  group('OccasionApiClient', () {
    test('getOccasions should return OccasionsResponse', () async {
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
        ],
      );

      when(mockOccasionApiClient.getOccasions(page: 1, limit: 10))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await mockOccasionApiClient.getOccasions(page: 1, limit: 10);

      // Assert
      expect(result, isA<OccasionsResponse>());
      expect(result.message, equals("success"));
      expect(result.occasions.first.name, equals("Birthday"));
      verify(mockOccasionApiClient.getOccasions(page: 1, limit: 10)).called(1);
    });

    test('getOccasions should return OccasionsResponse with empty parameters', () async {
      // Arrange
      final mockResponse = OccasionsResponse(
        message: "success",
        metadata: Metadata(
          currentPage: 1,
          limit: 10,
          totalPages: 1,
          totalItems: 0,
        ),
        occasions: [],
      );

      when(mockOccasionApiClient.getOccasions())
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await mockOccasionApiClient.getOccasions();

      // Assert
      expect(result, isA<OccasionsResponse>());
      expect(result.message, equals("success"));
      expect(result.occasions.length, equals(0));
      verify(mockOccasionApiClient.getOccasions()).called(1);
      verifyNoMoreInteractions(mockOccasionApiClient);
    });
  });

  group('OccasionApiClient Error Cases', () {
    test('getOccasions should throw DioException when API fails', () async {
      when(mockOccasionApiClient.getOccasions())
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/occasions'),
        type: DioExceptionType.badResponse,
      ));

      expect(
            () => mockOccasionApiClient.getOccasions(),
        throwsA(isA<DioException>()),
      );

      verify(mockOccasionApiClient.getOccasions()).called(1);
    });

    test('getOccasions should throw DioException with connection error', () async {
      when(mockOccasionApiClient.getOccasions(page: 2, limit: 20))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/occasions'),
        type: DioExceptionType.connectionError,
      ));

      expect(
            () => mockOccasionApiClient.getOccasions(page: 2, limit: 20),
        throwsA(isA<DioException>()),
      );

      verify(mockOccasionApiClient.getOccasions(page: 2, limit: 20)).called(1);
    });
  });
}