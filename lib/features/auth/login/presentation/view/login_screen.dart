import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/auth/domain/services/guest_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/Widgets/Custom_Elevated_Button.dart';
import '../../../../../core/Widgets/custom_text_field.dart';
import '../../../../../core/contants/app_images.dart';
import '../../../../../core/extensions/validations.dart';
import '../../../../../core/routes/route_names.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {},
                  child: Image.asset(AppImages.arrowBack)
                      .setHorizontalAndVerticalPadding(context, 0.05, 0.07)),
              Text(
                local!.login,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                    fontStyle: FontStyle.normal),
              ),
            ],
          ),
          CustomTextFormField(
              label: local.emailLabel,
              hint: local.emailHintText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return local.emailIsEmptyErrorMessage;
                }
                if (!Validations.validateEmail(value)) {
                  return local.emailValidationErrorMsg;
                }
                return null;
              }),
          const SizedBox(
            height: 20,
          ),
          CustomTextFormField(
            label: local.passwordLabel,
            hint: local.passwordHintText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return local.passwordRequiredErrorMsg;
              }
              if (!Validations.validatePassword(value)) {
                return local.passwordValidationErrorMsg;
              }
              return null;
            },
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
              Text(
                local.rememberMe,
                style: TextStyle(color: AppColors.black),
              ),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgetPassword);
                  },
                  child: Text(
                    local.forgetPasswordTextButton,
                    style: TextStyle(
                        color: AppColors.black[40],
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5,
                        fontSize: 15),
                  )),
            ],
          ),
          const SizedBox(
            height: 45,
          ),
          CustomElevatedButton(
            text: local.login,
            onPressed: () {},
          ),
          const SizedBox(
            height: 20,
          ),
          CustomElevatedButton(
            text: local.continueAsGuestButton,
            textColor: AppColors.grey,
            onPressed: () {
              GuestService.startGuestSession();
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.dashboard, (route) => false);
            },
            color: AppColors.white,
            borderColor: AppColors.grey,
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                local.dontHaveAnAccount,
                style: TextStyle(fontSize: 19),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    local.signUp,
                    style: TextStyle(
                        color: AppColors.pink,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5,
                        decorationColor: AppColors.pink,
                        fontSize: 19),
                  )),
            ],
          )
        ],
      ).setHorizontalPadding(context, 0.04),
    );
  }
}
