import 'package:flower_app/core/contants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/cart/presentation/view_model/cart_cubit.dart';
import '../../../../features/cart/presentation/view_model/cart_state.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: _buildNavBarItem(
                  AppIcons.homeIcon, local.explore, 0, context)),
          Expanded(
              child: _buildNavBarItem(
                  AppIcons.categoriesIcon, local.categories, 1, context)),
          Expanded(child: _buildCartNavBarItem(context, local.cart, 2)),
          Expanded(
              child: _buildNavBarItem(
                  AppIcons.profileIcon, local.profile, 3, context)),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(
      String icon, String label, int index, BuildContext context) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 30,
            width: 30,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.pink : AppColors.grey,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: isSelected ? AppColors.pink : AppColors.grey,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCartNavBarItem(BuildContext context, String label, int index) {
    final bool isSelected = currentIndex == index;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        int cartItemCount = 0;

        if (state is CartLoaded) {
          cartItemCount = state.cartResponse.numOfCartItems;
        } else if (state is CartLoading || state is CartInitial) {
          cartItemCount = 0;
        } else if (state is CartError) {
          cartItemCount = 0;
        }

        return GestureDetector(
          onTap: () => onTap(index),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    AppIcons.cartIcon,
                    height: 30,
                    width: 30,
                    colorFilter: ColorFilter.mode(
                      isSelected ? AppColors.pink : AppColors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                  if (cartItemCount > 0)
                    Positioned(
                      top: -8,
                      right: -8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.pink,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          cartItemCount > 9 ? '9+' : cartItemCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: isSelected ? AppColors.pink : AppColors.grey,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
