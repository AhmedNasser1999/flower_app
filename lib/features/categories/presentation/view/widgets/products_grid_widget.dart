import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/Widgets/products_card.dart';
import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_product_states.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../cart/presentation/view_model/cart_cubit.dart';

class ProductsGridWidget extends StatelessWidget {
  const ProductsGridWidget({super.key});

  int calculateDiscountPercentage(int originalPrice, int discountedPrice) {
    if (originalPrice <= 0 ||
        discountedPrice < 0 ||
        discountedPrice > originalPrice) {
      return 0;
    }
    double discount = ((originalPrice - discountedPrice) / originalPrice) * 100;
    return discount.round();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MostSellingProductsViewmodel, MostSellingProductStates>(
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
              height: 80,
              width: 80,
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
            padding: EdgeInsets.zero,
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
                productId: product.Id,
                productImg: product.imgCover,
                productPrice: product.price,
                productPriceDiscount: product.priceAfterDiscount,
                priceDiscount: calculateDiscountPercentage(
                  product.price,
                  product.priceAfterDiscount,
                ),
                productTitle: product.title,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.productDetails,
                    arguments: product,
                  );
                },
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
