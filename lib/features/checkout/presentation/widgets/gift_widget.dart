import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/Widgets/custom_text_field.dart';
import '../../../../core/l10n/translation/app_localizations.dart';

class GiftSection extends StatelessWidget {
  final bool enabled;
  final ValueChanged<bool> onChanged;
  final TextEditingController giftNameController;
  final TextEditingController giftPhoneController;

  const GiftSection({
    super.key,
    required this.enabled,
    required this.onChanged,
    required this.giftNameController,
    required this.giftPhoneController,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            Switch(
              value: enabled,
              onChanged: onChanged,
              activeTrackColor: Colors.pink,
            ),
            const SizedBox(width: 10),
            Text(local.itIsAGift, style: const TextStyle(fontSize: 18)),
          ],
        ).setHorizontalPadding(context, 0.05),
        const SizedBox(height: 10),
        CustomTextFormField(
          enabled: enabled,
                controller: giftNameController,
                hint: local.enterName,
                label: local.name)
            .setHorizontalPadding(context, 0.05),
        const SizedBox(height: 20),
        CustomTextFormField(
            enabled: enabled,
            controller: giftPhoneController,
                hint: local.enterPhoneNumber,
                label: local.phoneNumber)
            .setHorizontalPadding(context, 0.05),
      ],
    );
  }
}
