import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../viewmodel/home_cubit.dart';
import '../../viewmodel/home_state.dart';
import 'best_seller_list.dart';

class ProductsSection extends StatelessWidget {
  final HomeState state;
  const ProductsSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
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
              const Text('Error loading products'),
              ElevatedButton(
                onPressed: () => context.read<HomeCubit>().refreshProducts(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    } else {
      return BestSellerList(
        productList: state.productsList,
        onTap: (product) {
          Navigator.pushNamed(
            context,
            AppRoutes.productDetails,
            arguments: product,
          );
        },
      );
    }
  }
}
