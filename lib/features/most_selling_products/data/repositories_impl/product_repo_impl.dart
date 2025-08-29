import 'package:flower_app/features/most_selling_products/data/datasource/product_remote_datasource.dart';
import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/product_repo.dart';
import '../models/products_model.dart';

@LazySingleton(as: ProductRepo)
class ProductRepoImpl implements ProductRepo {
  final ProductRemoteDataSource _productRemoteDataSource;

  ProductRepoImpl(this._productRemoteDataSource);

  @override
  Future<List<ProductsEntity>> getAllProducts() async {
    final List<Products> models = await _productRemoteDataSource.getAllProduct();

    return models
        .map((model) => ProductsEntity(
              rateAvg: model.rateAvg,
              rateCount: model.rateCount,
              Id: model.Id,
              title: model.title,
              slug: model.slug,
              description: model.description,
              imgCover: model.imgCover,
              images: model.images,
              price: model.price,
              priceAfterDiscount: model.priceAfterDiscount,
              quantity: model.quantity,
              sold: model.sold,
              id: model.id,
              category: model.category,
              occasion: model.occasion, // Add occasion to entity
            ))
        .toList();
  }
}
