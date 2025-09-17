import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/routes/route_names.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../viewmodel/home_cubit.dart';

import '../../viewmodel/home_state.dart';
import 'category_list.dart';

class CategoriesSection extends StatelessWidget {
  final HomeState state;
  const CategoriesSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.isCategoriesLoading) {
      return Center(
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
    } else if (state.categoriesError != null) {
      return SizedBox(
        height: 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Error loading categories'),
              ElevatedButton(
                onPressed: () => context.read<HomeCubit>().refreshCategories(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    } else {
      return CategoryList(
        categories: state.categoriesList,
        onTap: (category) {
          Navigator.pushNamed(context, AppRoutes.categoriesScreen,
              arguments: category.Id);
        },
      );
    }
  }
}
