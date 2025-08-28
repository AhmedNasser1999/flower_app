import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final String title;
  const CategoryWidget(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.0,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            width: 68.0,
            height: 68.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: AppColors.lightPink,
            ),
            child: SvgPicture.asset(
              icon,
              width: 18,
              height: 22,
              colorFilter: ColorFilter.mode(AppColors.pink, BlendMode.srcIn),
            ),
          ),
        ),
        Text(title)
      ],
    );
  }
}
