import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const SectionHeader(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(

          title,
          style:  Theme.of(context).textTheme.headlineSmall,
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'View All',
            style: TextStyle(
              color: AppColors.pink,
              decorationColor: AppColors.pink ,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
