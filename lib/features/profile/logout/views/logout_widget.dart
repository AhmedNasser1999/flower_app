import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flutter/material.dart';

import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class LogoutDialogWidget extends StatelessWidget {
  const LogoutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      title: Text(locale!.logoutAlertMsg,
      textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text(locale.logoutConfirmTextCenter, textAlign: TextAlign.center,),
      actions: [
        Row(
          children: [
            CustomElevatedButton(
              width: 120,
              height: 50,
              color: AppColors.white,
              textColor: AppColors.grey,
              borderColor: AppColors.grey,
              text: locale.cancel, onPressed: () {  },),
            const SizedBox(width: 20,),
            CustomElevatedButton(
              width: 120,
              height: 50,
              text: locale.logout, onPressed: () {  },),
          ],
        )
      ]
    );
  }
}
