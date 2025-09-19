import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class DeliveryTimeSection extends StatelessWidget {
  const DeliveryTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(local.deliveryTime,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            Text(local.schedule,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.pink)),
          ],
        ).setHorizontalPadding(context, 0.05),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 5),
            Text(local.instant),
            Text(local.arrivesBy,
                style: TextStyle(
                    color: AppColors.green, fontWeight: FontWeight.w500)),
          ],
        ).setHorizontalPadding(context, 0.05),
      ],
    );
  }
}
