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

import '../../../../core/Widgets/section_header.dart';
import '../viewmodel/home_cubit.dart';
import '../viewmodel/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()
        ..getMostSellingProducts()
        ..getAllCategories(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          body: () {
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeSuccessState) {
              return SafeArea(
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
                          Navigator.pushNamed(context, AppRoutes.categoriesScreen);
                        },
                      ),
                      SizedBox(height: 10.0),
                      CategoryList(
                        onTap: () {},
                        categories: state.categories,
                      ),
                      SizedBox(height: 10.0),
                      SectionHeader(
                        title: 'Best Seller',
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.mostSellingProducts);
                        },
                      ),
                      BestSellerList(
                        productList: state.products,
                      ),
                      SectionHeader(
                        title: 'Occasion',
                        onPressed: () {},
                      ),
                      OccasionList(
                        image: 'assets/images/image.png',
                        name: 'Flower Name',
                        price: 600,
                      ),
                    ],
                  ).setHorizontalAndVerticalPadding(context, 0.05, 0.02),
                ),
              );
            } else if (state is HomeErrorState) {
              print('==================${state.message}=================');
            }
            return const SizedBox.shrink();
          }(),
        ),
      ),
    );
  }
}