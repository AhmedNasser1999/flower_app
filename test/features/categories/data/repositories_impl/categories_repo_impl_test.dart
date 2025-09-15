import 'package:flower_app/features/categories/data/datasource/categories_remote_datasource.dart' show GetCategoriesRemoteDataSource;
import 'package:flower_app/features/categories/data/models/categories_response.dart';
import 'package:flower_app/features/categories/data/models/category_model.dart';
import 'package:flower_app/features/categories/data/repositories_impl/categories_repo_impl.dart';
import 'package:flower_app/features/most_selling_products/data/models/meta_data_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_repo_impl_test.mocks.dart';

@GenerateMocks([GetCategoriesRemoteDataSource])
void main(){

  late CategoriesRepoImpl repo;

  late GetCategoriesRemoteDataSource remoteDataSource;

  setUp((){
    remoteDataSource = MockGetCategoriesRemoteDataSource();
    repo = CategoriesRepoImpl(remoteDataSource);

  });


  group("test get categories remote data source", (){
    test("Success state", ()async{
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
          Categories(
            Id: "673c472f1159920171827c8a",
            name: "gifts",
            slug: "gifts",
            image:
            "https://flower.elevateegy.com/uploads/79af9251-8534-4d50-8346-160f30589268-gift.png",
            createdAt: "2024-11-19T08:07:11.634Z",
            updatedAt: "2024-11-19T08:07:11.634Z",
            isSuperAdmin: true,
            productsCount: 0,
          ),
        ],
      );

      when(remoteDataSource.getAllCategories())
          .thenAnswer((_) async => fakeResponse);


      //act

      final result = await repo.getAllCategories();

      //assert
      expect(result.message, "success");
      expect(result.categories?.first.name, "flowers");

      verify(remoteDataSource.getAllCategories()).called(1);
    });

    test("Failure state", ()async{
      //arrange
      when(remoteDataSource.getAllCategories()).thenThrow(Exception("Something went wrong"));

      //act
      Future call() => repo.getAllCategories();

      expect(call, throwsA(isA<Exception>()));
      verify(remoteDataSource.getAllCategories()).called(1);

    });


  });

}

