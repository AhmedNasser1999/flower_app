import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/features/categories/presentation/viewmodel/categories_viewmodel.dart';
import 'widgets/search_and_filter_widget.dart';
import 'widgets/categories_tab_bar_widget.dart';
import 'widgets/products_grid_widget.dart';

class CategoriesScreen extends StatefulWidget {
  final String? initialCategoryId;
  const CategoriesScreen({super.key, this.initialCategoryId});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _currentTab = "All";
  String? _currentCategoryId;
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const SizedBox(height: 60),
          SearchAndFilterWidget(
            currentTab: _currentTab,
            categoryId: _currentCategoryId,
          ),
          const SizedBox(height: 10),
          CategoriesTabBarWidget(
            initialCategoryId: widget.initialCategoryId,
            onTabChanged: (tab, categoryId) {
              setState(() {
                _currentTab = tab;
                _currentCategoryId = categoryId;
              });
            },
          ),
          const SizedBox(height: 10),
          const Expanded(child: ProductsGridWidget(isFromCategories: true,)),
        ],
      ).setHorizontalPadding(context, 0.04),
    );
  }
}
