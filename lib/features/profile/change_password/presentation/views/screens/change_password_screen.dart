import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/Widgets/custom_text_field.dart';
import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flower_app/core/extensions/validations.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/profile/change_password/presentation/viewmodel/change_password_viewmodel.dart';
import 'package:flower_app/features/profile/change_password/presentation/viewmodel/states/change_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/common/widgets/custom_snackbar_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<ChangePasswordViewModel, ChangePasswordStates>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          showCustomSnackBar(context, state.message, isError: false);
        } else if (state is ChangePasswordError) {
          showCustomSnackBar(context, state.message, isError: true);
        }
      },
      builder: (context, state) {
        final viewModel = context.read<ChangePasswordViewModel>();

        return Scaffold(
          backgroundColor: AppColors.white,
          body: Form(
            key: formKey,
            onChanged: () {
              (context as Element).markNeedsBuild();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:
                              Image.asset("assets/icons/arrow_back_icon.png")),
                      const SizedBox(width: 20),
                      Text(
                        locale!.resetPassword,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Inter",
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 35),
                  CustomTextFormField(
                    hint: locale.currentPassword,
                    label: locale.currentPassword,
                    controller: viewModel.currentPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return locale.invalidPasswordMsg;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    hint: locale.newPassword,
                    label: locale.newPassword,
                    controller: viewModel.newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return locale.invalidPasswordMsg;
                      } else if (!Validations.validatePassword(value)) {
                        return locale.passwordValidationErrorMsg;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomTextFormField(
                    hint: locale.confirmPassword,
                    label: locale.confirmPassword,
                    controller: viewModel.confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return locale.passwordErrorMatchingMsg;
                      } else if (value !=
                          viewModel.newPasswordController.text) {
                        return locale.passwordErrorMatchingMsg;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  state is ChangePasswordLoading
                      ? const Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: LoadingIndicator(
                              indicatorType: Indicator.lineScalePulseOut,
                              colors: [AppColors.pink],
                              strokeWidth: 2,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        )
                      : CustomElevatedButton(
                          text: locale.updateText,
                          onPressed: formKey.currentState != null &&
                                  formKey.currentState!.validate()
                              ? () async {
                                  await viewModel.changePassword();
                                  Navigator.pop(context);
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    viewModel.currentPasswordController.clear();
                                    viewModel.newPasswordController.clear();
                                    viewModel.confirmPasswordController.clear();
                                  });
                                }
                              : null,
                        ),
                ],
              ).setHorizontalPadding(context, 0.05),
            ),
          ),
        );
      },
    );
  }
}
