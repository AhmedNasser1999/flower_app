import 'package:flutter_test/flutter_test.dart';
import 'package:flower_app/features/most_selling_products/data/models/products_reponse_model.dart';
import 'package:flower_app/features/most_selling_products/data/models/meta_data_model.dart';
import 'package:flower_app/features/most_selling_products/data/models/products_model.dart';

void main() {
  group('ProductsResponseModel', () {
    final mockJson = {
      "message": "Success",
      "metadata": {
        "currentPage": 1,
        "totalPages": 5,
        "limit": 10,
        "totalItems": 50
      },
      "products": [
        {
          "rateAvg": 4,
          "rateCount": 10,
          "_id": "p1",
          "title": "Red Roses",
          "slug": "red-roses",
          "description": "Beautiful red roses",
          "imgCover": "https://example.com/rose.jpg",
          "images": ["https://example.com/rose1.jpg"],
          "price": 200,
          "priceAfterDiscount": 150,
          "quantity": 5,
          "category": "Flowers",
          "occasion": "Valentine",
          "createdAt": "2025-01-01",
          "updatedAt": "2025-02-01",
          "__v": 1,
          "isSuperAdmin": false,
          "sold": 20,
          "id": "p1-id"
        }
      ]
    };

    test('fromJson should parse correctly', () {
      // Act
      final response = ProductsResponseModel.fromJson(mockJson);

      // Assert
      expect(response.message, "Success");
      expect(response.metadata.currentPage, 1);
      expect(response.metadata.totalPages, 5);
      expect(response.products.length, 1);
      expect(response.products.first.title, "Red Roses");
      expect(response.products.first.sold, 20);
    });

    test('toJson should return correct map', () {
      // Arrange
      final metadata = Metadata(
        currentPage: 1,
        totalPages: 5,
        limit: 10,
        totalItems: 50,
      );

      final product = Products(
        rateAvg: 4,
        rateCount: 100,
        Id: "1",
        title: "Rose",
        slug: "rose",
        description: "Beautiful flower",
        imgCover: "cover.jpg",
        images: ["img1.jpg", "img2.jpg"],
        price: 100,
        priceAfterDiscount: 90,
        quantity: 10,
        category: "Flowers",
        occasion: "Valentine",
        createdAt: "2025-01-01",
        updatedAt: "2025-01-02",
        V: 0,
        isSuperAdmin: false,
        sold: 200,
      );

      final model = ProductsResponseModel(
        message: "success",
        metadata: metadata,
        products: [product],
      );

      //Act
      final json = model.toJson();

      //Assert
      expect(json["message"], "success");
      expect((json["metadata"] as Metadata).totalPages, 5);
      expect((json["products"] as List<Products>).first.title, "Rose");
    });

    test('fromJson should handle missing optional fields with defaults', () {
      // Arrange
      final json = {
        "message": "Success",
        "metadata": {
          "currentPage": 1,
          "totalPages": 1,
          "limit": 10,
          "totalItems": 1
        },
        "products": [
          {
            "_id": "p1",
            "title": "Default Product",
            "slug": "default-product",
            "description": "desc",
            "imgCover": "cover.png",
          }
        ]
      };

      // Act
      final response = ProductsResponseModel.fromJson(json);

      // Assert
      final product = response.products.first;
      expect(product.price, 0);
      expect(product.images, isEmpty);
      expect(product.isSuperAdmin, false);
    });
  });
}
