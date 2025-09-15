import 'package:flower_app/features/most_selling_products/api/client/product_api_client.dart';
import 'package:flower_app/features/most_selling_products/api/datasource_impl/product_remote_datasource_impl.dart';
import 'package:flower_app/features/most_selling_products/data/models/meta_data_model.dart';
import 'package:flower_app/features/most_selling_products/data/models/products_model.dart';
import 'package:flower_app/features/most_selling_products/data/models/products_reponse_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'product_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ProductApiClient])
void main() {
  late MockProductApiClient mockProductApiClient;
  late ProductRemoteDataSourceImpl dataSource;

  setUp(() {
    mockProductApiClient = MockProductApiClient();
    dataSource = ProductRemoteDataSourceImpl(mockProductApiClient);
  });

  group('ProductRemoteDataSource success', () {
    test('getAllProduct returns list of products on success', () async{
      //Arrange
      final product = Products(
        Id: "123",
        title: "Flower Bouquet",
        slug: "flower-bouquet",
        description: "A beautiful bouquet",
        imgCover: "https://example.com/image.jpg",
        images: ["https://example.com/image1.jpg"],
        price: 200,
        priceAfterDiscount: 150,
        quantity: 5,
        category: "Roses",
        occasion: "Birthday",
        createdAt: "2025-08-28T12:00:00Z",
        updatedAt: "2025-08-28T12:00:00Z",
        isSuperAdmin: false,
        sold: 50,
        rateAvg: 4,
        rateCount: 10, V: 0,
      );

      final responseModel = ProductsResponseModel(
        message: "Success",
        metadata: Metadata(currentPage: 1, totalPages: 2, limit: 40, totalItems: 5),
        products: [product],
      );

      when(mockProductApiClient.getAllProducts()).thenAnswer((_) async => responseModel);

      //Act
      final result = await dataSource.getAllProduct();

      //Assert
      expect(result, isA<List<Products>>());
      expect(result.length, 1);
      expect(result.first.title, "Flower Bouquet");
      verify(mockProductApiClient.getAllProducts()).called(1);
    });

    test('getAllProduct throws exception when API fails', (){
      //Arrange
      when(mockProductApiClient.getAllProducts()).thenThrow(Exception("API error"));

      //Act
      final call= dataSource.getAllProduct;

      //Assert
      expect(()=> call(), throwsA(isA<Exception>()));
      verify(mockProductApiClient.getAllProducts()).called(1);
    });
  });
}
