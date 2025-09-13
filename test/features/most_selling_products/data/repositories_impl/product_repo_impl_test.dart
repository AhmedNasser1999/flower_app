import 'package:flower_app/features/most_selling_products/data/models/products_model.dart';
import 'package:flower_app/features/most_selling_products/data/repositories_impl/product_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_app/features/most_selling_products/data/datasource/product_remote_datasource.dart';
import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';

import 'product_repo_impl_test.mocks.dart';

@GenerateMocks([ProductRemoteDataSource])
void main() {
  late MockProductRemoteDataSource mockDataSource;
  late ProductRepoImpl repository;

  setUp(() {
    mockDataSource = MockProductRemoteDataSource();
    repository = ProductRepoImpl(mockDataSource);
  });

  group('ProductRepoImpl', () {
    test('should return list of ProductsEntity when data source succeeds',
        () async {
      // Arrange
      final productModel = Products(
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
        category: "Roses",
        occasion: "Birthday",
        createdAt: "2025-08-28",
        updatedAt: "2025-08-28",
        isSuperAdmin: false,
        rateAvg: 4,
        rateCount: 10,
        V: 0,
      );

      when(mockDataSource.getAllProduct())
          .thenAnswer((_) async => [productModel]);

      // Act
      final result = await repository.getAllProducts();

      // Assert
      expect(result, isA<List<ProductsEntity>>());
      expect(result.length, 1);
      expect(result.first.title, "Flower Bouquet");
      expect(result.first.priceAfterDiscount, 150);
      verify(mockDataSource.getAllProduct()).called(1);
    });

    test('should throw exception when data source fails', () async {
      // Arrange
      when(mockDataSource.getAllProduct()).thenThrow(Exception("API Error"));

      // Act
      final call = repository.getAllProducts;

      // Assert
      expect(() => call(), throwsA(isA<Exception>()));
      verify(mockDataSource.getAllProduct()).called(1);
    });

    test('should return empty list when data source returns empty list',
        () async {
      // Arrange
      when(mockDataSource.getAllProduct()).thenAnswer((_) async => []);

      // Act
      final result = await repository.getAllProducts();

      // Assert
      expect(result, isA<List<ProductsEntity>>());
      expect(result.isEmpty, true);
      verify(mockDataSource.getAllProduct()).called(1);
    });
  });
}
