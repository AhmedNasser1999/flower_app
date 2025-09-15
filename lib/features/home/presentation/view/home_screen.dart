import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/home/presentation/view/widgets/occison_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/core/Widgets/section_header.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
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
    var local = AppLocalizations.of(context);
    return BlocProvider(
      create: (_) => getIt<HomeCubit>()..initializeHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          backgroundColor: AppColors.white,
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
                    title: local!.categories,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.categoriesScreen);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  CategoriesSection(state: state),
                  const SizedBox(height: 10.0),
                  SectionHeader(
                    title: local.bestSeller,
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.mostSellingProducts);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  ProductsSection(state: state),
                  const SizedBox(height: 7.0),
                  SectionHeader(
                    title: local.occasion,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.occasions);
                    },
                  ),
                  const SizedBox(height: 5.0),
                  OccasionsSection(state: state),
                ],
              ).setHorizontalAndVerticalPadding(context, 0.0364, 0.0131),
            ),
          ),
        ),
      ),
    );
  }
}
