import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/Widgets/default_tab_bar_widget.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/categories/presentation/viewmodel/categories_states.dart';
import 'package:flower_app/features/categories/presentation/viewmodel/categories_viewmodel.dart';
import 'package:flower_app/features/most_selling_products/presentation/viewmodel/most_selling_products_viewmodel.dart';

class CategoriesTabBarWidget extends StatefulWidget {
  final String? initialCategoryId;
  final Function(String tab, String? categoryId) onTabChanged;

  const CategoriesTabBarWidget({
    super.key,
    required this.onTabChanged,
    this.initialCategoryId,
  });

  @override
  State<CategoriesTabBarWidget> createState() => _CategoriesTabBarWidgetState();
}

class _CategoriesTabBarWidgetState extends State<CategoriesTabBarWidget> {
  bool _didFetchInitial = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is GetAllCategoriesSuccess) {
          final categories = state.categories;
          final tabs = ["All", ...categories.map((c) => c.name ?? "")];

          int initialIndex = 0;
          if (widget.initialCategoryId != null) {
            final idx =
                categories.indexWhere((c) => c.Id == widget.initialCategoryId);
            if (idx != -1) initialIndex = idx + 1;
          }

          if (!_didFetchInitial) {
            _didFetchInitial = true;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;

              if (initialIndex == 0) {
                context
                    .read<MostSellingProductsViewmodel>()
                    .getMostSellingProducts();
                widget.onTabChanged("All", null);
              } else {
                final selectedCategory = categories[initialIndex - 1];
                context
                    .read<MostSellingProductsViewmodel>()
                    .getProduct(category: selectedCategory.Id);
                widget.onTabChanged(
                    selectedCategory.name ?? "", selectedCategory.Id);
              }
            });
          }

          return DefaultTabBarWidget(
            tabs: tabs,
            initialIndex: initialIndex,
            onTabSelected: (selectedTab) {
              if (selectedTab == "All") {
                context.read<MostSellingProductsViewmodel>().getProduct();
                widget.onTabChanged(selectedTab, null);
              } else {
                final selectedCategory = categories.firstWhere(
                  (c) => c.name == selectedTab,
                );
                context
                    .read<MostSellingProductsViewmodel>()
                    .getProduct(category: selectedCategory.Id);
                widget.onTabChanged(selectedTab, selectedCategory.Id);
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
