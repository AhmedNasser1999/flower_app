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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<LoginViewModel, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineScalePulseOut,
                        colors: [AppColors.pink],
                        strokeWidth: 2,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Loading',
                      style: TextStyle(
                        fontFamily: "Janna",
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.pink,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is LoginSuccessState) {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.dashboard,
              (route) => false,
            );
          } else if (state is LoginErrorState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMsg)),
            );
          }
        },
        builder: (BuildContext context, LoginStates state) {
          final viewModel = context.read<LoginViewModel>();
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(AppImages.arrowBack)
                            .setHorizontalAndVerticalPadding(
                                context, 0.05, 0.07),
                      ),
                      Text(
                        local!.login,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Inter",
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                  CustomTextFormField(
                    controller: viewModel.emailController,
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
                    },
                  ),
                  const SizedBox(height: 18),
                  CustomTextFormField(
                    controller: viewModel.passwordController,
                    label: local.passwordLabel,
                    hint: local.passwordHintText,
                    obscureText: true,
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
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Checkbox(
                          value: viewModel.rememberMe, onChanged: (value) {
                            setState(() {
                              viewModel.toggleRememberMe(value ?? false);
                            });
                      }),
                      Text(
                        local.rememberMe,
                        style: const TextStyle(color: AppColors.black),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          local.forgetPasswordTextButton,
                          style: TextStyle(
                            color: AppColors.black.withOpacity(0.4),
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomElevatedButton(
                    text: local.login,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        viewModel.login(
                          viewModel.emailController.text,
                          viewModel.passwordController.text,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    text: local.continueAsGuestButton,
                    textColor: AppColors.grey,
                    onPressed: () async {
                      try {
                        await GuestService.startGuestSession();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.dashboard,
                              (route) => false,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to start guest session: $e')),
                        );
                      }
                    },
                    color: AppColors.white,
                    borderColor: AppColors.grey,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        local.dontHaveAnAccount,
                        style: const TextStyle(fontSize: 19),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          local.signUp,
                          style: const TextStyle(
                            color: AppColors.pink,
                            decoration: TextDecoration.underline,
                            decorationThickness: 1.5,
                            decorationColor: AppColors.pink,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ).setHorizontalPadding(context, 0.04),
            ),
          );
        },
      ),
    );
  }
}
