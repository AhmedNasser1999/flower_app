// features/occasion/presentation/view/occasion_screen.dart
import 'package:flower_app/core/Widgets/products_card.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/categories/presentation/viewmodel/categories_states.dart';
import 'package:flower_app/features/categories/presentation/viewmodel/categories_viewmodel.dart';
import 'package:flower_app/features/most_selling_products/domain/entity/products_entity.dart';
import 'package:flower_app/features/occasion/presentation/viewmodel/occasion_states.dart';
import 'package:flower_app/features/occasion/presentation/viewmodel/occasion_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class OccasionScreen extends StatelessWidget {
  const OccasionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => context.read<OccasionViewmodel>(),
        ),
        BlocProvider(
          create: (context) =>
              context.read<CategoriesCubit>()..getAllCategories(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                local.occasionsTitle,
                style: theme.textTheme.headlineMedium,
              ),
              Text(
                local.occasionsSubTitle,
                style: theme.textTheme.displayMedium,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, categoriesState) {
                if (categoriesState is GetAllCategoriesLoading) {
                  return const SizedBox(
                    height: 60,
                    child: Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineScalePulseOut,
                          colors: [AppColors.pink],
                          strokeWidth: 2,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  );
                } else if (categoriesState is GetAllCategoriesSuccess) {
                  return SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: categoriesState.categories.length,
                      itemBuilder: (context, index) {
                        final category = categoriesState.categories[index];
                        final isSelected = context
                                .watch<OccasionViewmodel>()
                                .selectedOccasionId ==
                            category.Id;

                        return GestureDetector(
                          onTap: () {
                            context
                                .read<OccasionViewmodel>()
                                .getOccasionProducts(category.Id!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Column(
                              children: [
                                Text(
                                  category.name ?? "",
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: isSelected
                                        ? AppColors.pink
                                        : Colors.grey,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 2,
                                  color: isSelected
                                      ? AppColors.pink
                                      : Colors.grey[400],
                                  width: 40,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (categoriesState is GetAllCategoriesError) {
                  return SizedBox(
                    height: 60,
                    child: Center(
                      child: Text(
                        'Failed to load categories',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: AppColors.red),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(height: 60);
                }
              },
            ),
            Expanded(
              child: BlocBuilder<OccasionViewmodel, OccasionState>(
                builder: (context, state) {
                  if (state is OccasionLoading) {
                    return Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineScalePulseOut,
                          colors: [AppColors.pink],
                          strokeWidth: 2,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    );
                  } else if (state is OccasionLoaded) {
                    return RefreshIndicator(
                      onRefresh: () => context
                          .read<OccasionViewmodel>()
                          .refreshOccasionProducts(),
                      color: AppColors.pink,
                      backgroundColor: AppColors.white,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
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
                      ),
                    );
                  } else if (state is OccasionError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Error: ${state.message}"),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              final selectedOccasionId = context
                                  .read<OccasionViewmodel>()
                                  .selectedOccasionId;
                              if (selectedOccasionId != null) {
                                context
                                    .read<OccasionViewmodel>()
                                    .getOccasionProducts(selectedOccasionId);
                              }
                            },
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('Select a category to see products'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int calculateDiscountPercentage(int originalPrice, int discountedPrice) {
    if (originalPrice <= 0 ||
        discountedPrice < 0 ||
        discountedPrice > originalPrice) {
      return 0;
    }
    double discount = ((originalPrice - discountedPrice) / originalPrice) * 100;
    return discount.round();
  }
}
