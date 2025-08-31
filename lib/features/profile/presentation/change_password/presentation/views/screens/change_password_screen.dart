import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/Widgets/custom_text_field.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/extensions/validations.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/l10n/translation/app_localizations.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(children: [
        const SizedBox(height: 60),
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("assets/icons/arrow_back_icon.png")),
            const SizedBox(width: 20),
            Text(
              locale!.resetPassword,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "Inter",
                fontSize: 22,
              ),
            )
          ],
        ),
        const SizedBox(height: 50),
        CustomTextFormField(
          hint: locale.currentPassword,
          label: locale.currentPassword,
          controller: _currentPasswordController,
          validator: (value) {
            if(value == null || value.isEmpty) {
              return locale.invalidPasswordMsg;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          hint: locale.newPassword,
          label: locale.newPassword,
          controller: _newPasswordController,
          validator: (value) {
            if(value == null || value.isEmpty) {
              return locale.invalidPasswordMsg;
            } else if(!Validations.validatePassword(value)) {
              return locale.passwordValidationErrorMsg;
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextFormField(
          hint: locale.confirmPassword,
          label: locale.confirmPassword,
          controller: _confirmPasswordController,
          validator: (value) {
            if(value == null || value.isEmpty) {
              return locale.passwordErrorMatchingMsg;
            }
            else if(value != _newPasswordController.text) {
              return locale.passwordErrorMatchingMsg;
            }
            return null;
          },
        ),
        const SizedBox(height: 40),
        CustomElevatedButton(text: locale.updateText, onPressed: (){})
        
      ]).setHorizontalPadding(context, 0.05),
    );
  }
}
