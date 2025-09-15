import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../l10n/translation/app_localizations.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const SectionHeader(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            local.viewAll,
            style: TextStyle(
              color: AppColors.pink,
              decorationColor: AppColors.pink,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
