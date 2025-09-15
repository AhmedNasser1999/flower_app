import 'package:flower_app/features/categories/domain/usecases/get_category_byId_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_app/features/categories/domain/repositories/categories_repo.dart';
import 'package:flower_app/features/categories/data/models/categoryResponse_byId_model.dart';
import 'package:flower_app/features/categories/data/models/category_model.dart';

import 'get_all_categories_usecase_test.mocks.dart';

@GenerateMocks([CategoriesRepo])
void main() {
  late GetCategoryByIdUseCase usecase;
  late MockCategoriesRepo mockRepo;

  setUp(() {
    mockRepo = MockCategoriesRepo();
    usecase = GetCategoryByIdUseCase(mockRepo);
  });

  group('GetCategoryByIdUseCase', () {
    const categoryId = "673c46fd1159920171827c85";

    test('should return CategoryDetailsResponse when repo returns data', () async {
      // arrange
      final fakeCategory = Categories(
        Id: categoryId,
        name: "flowers",
        slug: "flowers",
        image:
        "https://flower.elevateegy.com/uploads/39c641a6-4ec4-421a-8f55-5d8f5eeba5c3-flowers.png",
        createdAt: "2024-11-19T08:06:21.263Z",
        updatedAt: "2024-11-19T08:06:21.263Z",
        isSuperAdmin: true,
        productsCount: 15,
      );

      final fakeResponse = CategoryDetailsResponse(
        message: "success",
        category: fakeCategory,
      );

      when(mockRepo.getCategoryById(categoryId))
          .thenAnswer((_) async => fakeResponse);

      // act
      final result = await usecase(categoryId);

      // assert
      expect(result.message, "success");
      expect(result.category?.Id, categoryId);
      expect(result.category?.name, "flowers");

      verify(mockRepo.getCategoryById(categoryId)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('should throw Exception when repo throws', () async {
      // arrange
      when(mockRepo.getCategoryById(categoryId))
          .thenThrow(Exception("Not found"));

      // act
      Future call() => usecase(categoryId);

      // assert
      expect(call, throwsA(isA<Exception>()));
      verify(mockRepo.getCategoryById(categoryId)).called(1);
    });
  });
}
