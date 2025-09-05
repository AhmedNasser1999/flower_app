import 'package:flower_app/features/home/presentation/view/widgets/occison_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/core/Widgets/section_header.dart';

import '../viewmodel/home_cubit.dart';
import '../viewmodel/home_state.dart';
import 'widgets/app_logo.dart';
import 'widgets/order_info.dart';
import 'widgets/categories_section.dart';
import 'widgets/products_section.dart';

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
                  const AppLogo(),
                  const SizedBox(height: 10.0),
                  const OrderInfo(),
                  const SizedBox(height: 10.0),
                  SectionHeader(
                    title: 'Categories',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.categoriesScreen);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  CategoriesSection(state: state),
                  const SizedBox(height: 10.0),
                  SectionHeader(
                    title: 'Best Seller',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.mostSellingProducts);
                    },
                  ),
                  ProductsSection(state: state),
                  SectionHeader(
                    title: 'Occasion',
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.occasions);
                    },
                  ),
                  OccasionsSection(state: state),
                ],
              ).setHorizontalAndVerticalPadding(context, 0.05, 0.02),
            ),
          ),
        ),
      ),
    );
  }
}
