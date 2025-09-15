import 'package:flutter/material.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import 'package:flower_app/core/widgets/custom_elevated_button.dart';
import '../../../../core/theme/app_colors.dart';

class LoginRequiredDialog extends StatelessWidget {
  const LoginRequiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      title: Text(
        locale.loginRequiredTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: "Inter",
        ),
      ),
      content: Text(
        locale.loginRequiredMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: "Inter",
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              width: 120,
              height: 50,
              color: AppColors.white,
              textColor: AppColors.grey,
              borderColor: AppColors.grey,
              text: locale.cancel,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 20),
            CustomElevatedButton(
              width: 120,
              height: 50,
              text: locale.login,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context,AppRoutes.login);
              },
            ),
          ],
        ),
      ],
    );
  }
}

