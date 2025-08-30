import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:flower_app/features/occasion/domain/entity/occasion_entity.dart';
import 'package:flower_app/features/categories/data/models/category_model.dart';

class HomeState {
  // Categories
  bool isCategoriesLoading;
  List<Categories> categoriesList;
  String? categoriesError;

  // Products
  bool isProductsLoading;
  List<ProductsEntity> productsList;
  String? productsError;

  // Occasions
  bool isOccasionsLoading;
  List<OccasionEntity> occasionsList;
  String? occasionsError;

  HomeState({
    this.isCategoriesLoading = true,
    this.categoriesList = const [],
    this.categoriesError,
    this.isProductsLoading = true,
    this.productsList = const [],
    this.productsError,
    this.isOccasionsLoading = true,
    this.occasionsList = const [],
    this.occasionsError,
  });

  HomeState copyWith({
    bool? isCategoriesLoadingArg,
    List<Categories>? categoriesListArg,
    String? categoriesErrorArg,
    bool? isProductsLoadingArg,
    List<ProductsEntity>? productsListArg,
    String? productsErrorArg,
    bool? isOccasionsLoadingArg,
    List<OccasionEntity>? occasionsListArg,
    String? occasionsErrorArg,
  }) {
    return HomeState(
      isCategoriesLoading: isCategoriesLoadingArg ?? isCategoriesLoading,
      categoriesList: categoriesListArg ?? categoriesList,
      categoriesError: categoriesErrorArg,
      isProductsLoading: isProductsLoadingArg ?? isProductsLoading,
      productsList: productsListArg ?? productsList,
      productsError: productsErrorArg,
      isOccasionsLoading: isOccasionsLoadingArg ?? isOccasionsLoading,
      occasionsList: occasionsListArg ?? occasionsList,
      occasionsError: occasionsErrorArg,
    );
  }
}
