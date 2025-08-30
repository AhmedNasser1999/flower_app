import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/features/home/presentation/view/widgets/app_logo.dart';
import 'package:flower_app/features/home/presentation/view/widgets/best_seller_list.dart';
import 'package:flower_app/features/home/presentation/view/widgets/category_list.dart';
import 'package:flower_app/features/home/presentation/view/widgets/occasion_list.dart';
import 'package:flower_app/features/home/presentation/view/widgets/order_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/Widgets/section_header.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodel/home_cubit.dart';
import '../viewmodel/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..initializeHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppLogo(),
                  SizedBox(height: 10.0),
                  OrderInfo(),
                  SizedBox(height: 10.0),
                  SectionHeader(
                    title: 'Categories',
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.categoriesScreen);
                    },
                  ),
                  SizedBox(height: 10.0),
                  _buildCategoriesSection(context, state),
                  SizedBox(height: 10.0),
                  SectionHeader(
                    title: 'Best Seller',
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.mostSellingProducts);
                    },
                  ),
                  _buildProductsSection(context, state),
                  SectionHeader(
                    title: 'Occasion',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.occasions);
                    },
                  ),
                  _buildOccasionsSection(context, state),
                ],
              ).setHorizontalAndVerticalPadding(context, 0.05, 0.02),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context, HomeState state) {
    if (state.isCategoriesLoading) {
      return  Center(
        child: SizedBox(
          height: 150,
          width: 100,
          child: LoadingIndicator(
            indicatorType: Indicator.lineScalePulseOut,
            colors: [AppColors.pink],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
          ),
        ),
      );
    } else if (state.categoriesError != null) {
      return SizedBox(
        height: 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error loading categories'),
              ElevatedButton(
                onPressed: () => context.read<HomeCubit>().refreshCategories(),
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    } else {
      return CategoryList(
        categories: state.categoriesList,
        onTap: (category) {
          print("Category tapped: ${category.Id}");
          // context.read<CategoriesCubit>().getCategoryDetails(category.Id ?? "");
        },
      );
    }
  }

  Widget _buildProductsSection(BuildContext context, HomeState state) {
    if (state.isProductsLoading) {
       return const Center(
        child: SizedBox(
          height: 150,
          width: 100,
          child: LoadingIndicator(
            indicatorType: Indicator.lineScalePulseOut,
            colors: [AppColors.pink],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
          ),
        ),
      );
    } else if (state.productsError != null) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error loading products'),
              ElevatedButton(
                onPressed: () => context.read<HomeCubit>().refreshProducts(),
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    } else {
      return BestSellerList(
        productList: state.productsList,
      );
    }
  }

  Widget _buildOccasionsSection(BuildContext context, HomeState state) {
    if (state.isOccasionsLoading) {
      return const Center(
        child: SizedBox(
          height: 150,
          width: 100,
          child: LoadingIndicator(
            indicatorType: Indicator.lineScalePulseOut,
            colors: [AppColors.pink],
            strokeWidth: 2,
            backgroundColor: Colors.transparent,
          ),
        ),
      );
    } else if (state.occasionsError != null) {
      return SizedBox(
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error loading occasions'),
              ElevatedButton(
                onPressed: () => context.read<HomeCubit>().refreshOccasions(),
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    } else {
      return OccasionList(
        occasionList: state.occasionsList,
      );
    }
  }
}
