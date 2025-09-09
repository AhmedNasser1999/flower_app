import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flower_app/core/Widgets/default_tab_bar_widget.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/categories/presentation/viewmodel/categories_states.dart';
import 'package:flower_app/features/categories/presentation/viewmodel/categories_viewmodel.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';

class CategoriesTabBarWidget extends StatelessWidget {
  final Function(String tab, String? categoryId) onTabChanged;

  const CategoriesTabBarWidget({
    super.key,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is GetAllCategoriesSuccess) {
          final categories = state.categories;
          final tabs = ["All", ...categories.map((c) => c.name ?? "").toList()];

          return DefaultTabBarWidget(
            tabs: tabs,
            onTabSelected: (selectedTab) {
              if (selectedTab == "All") {
                context.read<MostSellingProductsViewmodel>().getProduct();
                onTabChanged(selectedTab, null);
              } else {
                final selectedCategory = categories.firstWhere(
                      (c) => c.name == selectedTab,
                );
                context.read<MostSellingProductsViewmodel>().getProduct(category: selectedCategory.Id);
                onTabChanged(selectedTab, selectedCategory.Id);
              }
            },
          );
        } else if (state is GetAllCategoriesLoading) {
          return const Center(
            child: LinearProgressIndicator(
              color: AppColors.pink,
              backgroundColor: AppColors.white,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
