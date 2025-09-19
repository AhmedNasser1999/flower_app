import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/l10n/translation/app_localizations.dart';

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 25),
        ),
        Text(
          local.checkout,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            fontFamily: "Janna",
          ),
        )
      ],
    ).setHorizontalPadding(context, 0.02);
  }
}
