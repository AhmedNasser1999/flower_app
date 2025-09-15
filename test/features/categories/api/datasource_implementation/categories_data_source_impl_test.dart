import 'package:dio/dio.dart';
import 'package:flower_app/features/categories/api/client/categories_api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_app/features/categories/data/models/categories_response.dart';
import 'package:flower_app/features/categories/data/models/category_model.dart';
import 'package:flower_app/features/categories/data/models/categoryResponse_byId_model.dart';

import 'categories_data_source_impl_test.mocks.dart';

@GenerateMocks([CategoryApiClient])
void main() {
  late MockCategoryApiClient mockCategoryApiClient;

  setUp(() {
    mockCategoryApiClient = MockCategoryApiClient();
  });

  group('CategoryApiClient', () {
    test('getAllCategories should return CategoriesResponse', () async {
      // Arrange
      final mockResponse = CategoriesResponse(
        message: "success",
        categories: [
          Categories(
            Id: "1",
            name: "Flowers",
            slug: "flowers",
            image: "https://example.com/flowers.png",
            createdAt: "2024-08-01",
            updatedAt: "2024-08-10",
            isSuperAdmin: false,
            productsCount: 5,
          ),
        ],
      );

      when(mockCategoryApiClient.getAllCategories())
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await mockCategoryApiClient.getAllCategories();

      // Assert
      expect(result, isA<CategoriesResponse>());
      expect(result.message, equals("success"));
      expect(result.categories?.first.name, equals("Flowers"));
      verify(mockCategoryApiClient.getAllCategories()).called(1);
    });

    test('getCategoryById should return CategoryDetailsResponse', () async {
      // Arrange
      final mockCategory = Categories(
        Id: "2",
        name: "Roses",
        slug: "roses",
        image: "https://example.com/roses.png",
        createdAt: "2024-08-02",
        updatedAt: "2024-08-11",
        isSuperAdmin: false,
        productsCount: 10,
      );

      final mockDetailsResponse = CategoryDetailsResponse(
        message: "category found",
        category: mockCategory,
      );

      when(mockCategoryApiClient.getCategoryById("2"))
          .thenAnswer((_) async => mockDetailsResponse);

      // Act
      final result = await mockCategoryApiClient.getCategoryById("2");

      // Assert
      expect(result, isA<CategoryDetailsResponse>());
      expect(result.message, equals("category found"));
      expect(result.category?.name, equals("Roses"));
      verify(mockCategoryApiClient.getCategoryById("2")).called(1);
      verifyNoMoreInteractions(mockCategoryApiClient);
    });
  });

  group('CategoryApiClient Error Cases', () {
    test('getAllCategories should throw DioException when API fails', () async {
      when(mockCategoryApiClient.getAllCategories()).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/categories'),
        type: DioExceptionType.badResponse,
      ));

      expect(
        () => mockCategoryApiClient.getAllCategories(),
        throwsA(isA<DioException>()),
      );

      verify(mockCategoryApiClient.getAllCategories()).called(1);
    });

    test('getCategoryById should throw DioException when API fails', () async {
      when(mockCategoryApiClient.getCategoryById("5")).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/categories/5'),
        type: DioExceptionType.connectionError,
      ));

      expect(
        () => mockCategoryApiClient.getCategoryById("5"),
        throwsA(isA<DioException>()),
      );

      verify(mockCategoryApiClient.getCategoryById("5")).called(1);
    });
  });
}
