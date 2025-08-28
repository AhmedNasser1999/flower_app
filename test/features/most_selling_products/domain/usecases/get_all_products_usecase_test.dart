import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:flower_app/features/most_selling_products/domain/repositories/product_repo.dart';
import 'package:flower_app/features/most_selling_products/domain/usecases/get_all_products_usecase.dart';

import 'get_all_products_usecase_test.mocks.dart';

@GenerateMocks([ProductRepo])
void main() {
  late MockProductRepo mockProductRepo;
  late GetAllProductsUseCase useCase;

  setUp(() {
    mockProductRepo = MockProductRepo();
    useCase = GetAllProductsUseCase(mockProductRepo);
  });

  group('GetAllProductsUseCase', () {
    test('should return list of ProductsEntity when repo succeeds', () async {
      // Arrange
      final productEntity = ProductsEntity(
        Id: "123",
        id: "123",
        title: "Flower Bouquet",
        slug: "flower-bouquet",
        description: "A beautiful bouquet",
        imgCover: "https://example.com/image.jpg",
        images: ["https://example.com/img1.jpg"],
        price: 200,
        priceAfterDiscount: 150,
        quantity: 5,
        sold: 20,
        rateAvg: 4,
        rateCount: 10,
      );

      when(mockProductRepo.getAllProducts())
          .thenAnswer((_) async => [productEntity]);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<List<ProductsEntity>>());
      expect(result.length, 1);
      expect(result.first.title, "Flower Bouquet");
      verify(mockProductRepo.getAllProducts()).called(1);
    });

    test('should throw exception when repo fails', () async {
      // Arrange
      when(mockProductRepo.getAllProducts())
          .thenThrow(Exception("Repo error"));

      // Act
      final call = useCase;

      // Assert
      expect(() => call(), throwsA(isA<Exception>()));
      verify(mockProductRepo.getAllProducts()).called(1);
    });

    test('should return empty list when repo returns empty', () async {
      // Arrange
      when(mockProductRepo.getAllProducts()).thenAnswer((_) async => []);

      // Act
      final result = await useCase();

      // Assert
      expect(result, isA<List<ProductsEntity>>());
      expect(result.isEmpty, true);
      verify(mockProductRepo.getAllProducts()).called(1);
    });
  });
}
