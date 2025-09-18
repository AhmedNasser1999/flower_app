import 'package:flower_app/core/contants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

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
          Expanded(
              child:
                  _buildNavBarItem(AppIcons.cartIcon, local.cart, 2, context)),
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
          SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: isSelected ? AppColors.pink : AppColors.grey,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
