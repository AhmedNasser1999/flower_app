import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_product_states.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/Widgets/products_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (_) => null,
                  onChanged: (value) {
                    context.read<MostSellingProductsViewmodel>().filterProducts(value);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 64,
                height: 59,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  border: Border.all(color: AppColors.grey, width: 0.9),
                ),
                child: GestureDetector(
                  child: Image.asset("assets/icons/filter-Icon.png"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocConsumer<MostSellingProductsViewmodel, MostSellingProductStates>(
              listener: (context, state) {
                if (state is MostSellingProductsErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is MostSellingLoadingState) {
                  return const Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineScalePulseOut,
                        colors: [AppColors.pink],
                        strokeWidth: 2,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  );
                } else if (state is MostSellingSuccessState) {
                  final List<ProductsEntity> products = state.products;

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        productImg: product.imgCover,
                        productPrice: product.price,
                        productPriceDiscount: product.priceAfterDiscount,
                        priceDiscount: calculateDiscountPercentage(
                          product.price,
                          product.priceAfterDiscount,
                        ),
                        productTitle: product.title,
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ).setHorizontalPadding(context, 0.04),
    );
  }

  int calculateDiscountPercentage(int originalPrice, int discountedPrice) {
    if (originalPrice <= 0 || discountedPrice < 0 || discountedPrice > originalPrice) {
      return 0; // fallback
    }
    double discount = ((originalPrice - discountedPrice) / originalPrice) * 100;
    return discount.round();
  }
}
