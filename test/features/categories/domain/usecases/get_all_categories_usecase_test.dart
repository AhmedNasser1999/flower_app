import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_app/features/categories/domain/repositories/categories_repo.dart';
import 'package:flower_app/features/categories/domain/usecases/get_all_categories_usecase.dart';
import 'package:flower_app/features/categories/data/models/categories_response.dart';
import 'package:flower_app/features/categories/data/models/category_model.dart';
import 'package:flower_app/features/most_selling_products/data/models/meta_data_model.dart';

import 'get_all_categories_usecase_test.mocks.dart';

@GenerateMocks([CategoriesRepo])
void main() {
  late GetAllCategoriesUseCase usecase;
  late MockCategoriesRepo mockRepo;

  setUp(() {
    mockRepo = MockCategoriesRepo();
    usecase = GetAllCategoriesUseCase(mockRepo);
  });

  group('GetAllCategoriesUseCase', () {
    test('should return CategoriesResponse when repo returns data', () async {
      // arrange
      final fakeResponse = CategoriesResponse(
        message: "success",
        metadata: Metadata(
          currentPage: 1,
          limit: 10,
          totalPages: 2,
          totalItems: 12,
        ),
        categories: [
          Categories(
            Id: "673c46fd1159920171827c85",
            name: "flowers",
            slug: "flowers",
            image:
            "https://flower.elevateegy.com/uploads/39c641a6-4ec4-421a-8f55-5d8f5eeba5c3-flowers.png",
            createdAt: "2024-11-19T08:06:21.263Z",
            updatedAt: "2024-11-19T08:06:21.263Z",
            isSuperAdmin: true,
            productsCount: 15,
          ),
        ],
      );

      when(mockRepo.getAllCategories())
          .thenAnswer((_) async => fakeResponse);

      // act
      final result = await usecase();

      // assert
      expect(result.message, "success");
      expect(result.categories?.length, 1);
      expect(result.categories?.first.name, "flowers");

      verify(mockRepo.getAllCategories()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should throw Exception when repo throws', () async {
      // arrange
      when(mockRepo.getAllCategories())
          .thenThrow(Exception("Server error"));

      // act
      Future call() => usecase();

      // assert
      expect(call, throwsA(isA<Exception>()));
      verify(mockRepo.getAllCategories()).called(1);
    });
  });
}
