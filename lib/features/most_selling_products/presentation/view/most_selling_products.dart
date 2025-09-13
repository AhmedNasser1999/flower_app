import 'package:flower_app/core/contants/app_images.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/Widgets/products_card.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodel/most_selling_product_states.dart';
import '../viewmodel/most_selling_products_viewmodel.dart';

class MostSellingProducts extends StatelessWidget {
  const MostSellingProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(AppImages.arrowBack),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local.mostSellingTitle,
                style: theme.textTheme.headlineMedium,
              ),
              Text(
                local.mostSellingSubTitle,
                style: theme.textTheme.displayMedium,
              ),
            ],
          ),
        ),
        body:
            BlocBuilder<MostSellingProductsViewmodel, MostSellingProductStates>(
          builder: (context, state) {
            if (state is MostSellingLoadingState) {
              return Center(child: SizedBox(
                height: 50,
                width: 50,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOut,
                  colors: [AppColors.pink],
                  strokeWidth: 2,
                  backgroundColor: Colors.transparent,
                ),
              ));
            } else if (state is MostSellingSuccessState) {
              final List<ProductsEntity> products = state.products;
              products.sort((a, b) => b.sold.compareTo(a.sold));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return ProductCard(
                          productImg: product.imgCover,
                          productPrice: product.price,
                          productPriceDiscount: product.priceAfterDiscount,
                          priceDiscount: ((product.price - product.priceAfterDiscount) /
                              product.price *
                              100)
                              .round(),
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
                    ),
                  )
                ],
              ).setHorizontalAndVerticalPadding(context, 0.05, 0.02);
            }
            else if (state is MostSellingProductsErrorState) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}

