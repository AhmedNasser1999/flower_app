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
    final List<Products> models =
        await _productRemoteDataSource.getAllProduct();

    return models
        .map((models) => ProductsEntity(
            rateAvg: models.rateAvg,
            rateCount: models.rateCount,
            Id: models.Id,
            title: models.title,
            slug: models.slug,
            description: models.description,
            imgCover: models.imgCover,
            images: models.images,
            price: models.price,
            priceAfterDiscount: models.priceAfterDiscount,
            quantity: models.quantity,
            sold: models.sold,
            id: models.id,
      category: models.category,

    ),
    ).toList();
  }
}
