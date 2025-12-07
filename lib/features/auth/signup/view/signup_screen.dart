import 'package:flower_app/core/Widgets/custom_Elevated_Button.dart';
import 'package:flower_app/core/Widgets/custom_text_field.dart';
import 'package:flower_app/core/Widgets/messages/messages_methods.dart';
import 'package:flower_app/core/extensions/validations.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:flower_app/features/auth/signup/cubit/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../core/common/widgets/custom_snackbar_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return BlocConsumer<SignupCubit, SignupStates>(
      listener: (context, state) {
        if (state is SignupLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
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
                    local.loading,
                    style: const TextStyle(
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
        } else if (state is SignupSuccessState) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
          showCustomSnackBar(context, local.signup_success, isError: false);
        } else if (state is SignupErrorState) {
          Navigator.pop(context);
          showCustomSnackBar(context, state.errorMessage, isError: true);
        }
      },
      builder: (context, state) {
        final cubit = context.read<SignupCubit>();
        return Form(
          key: cubit.signUpFormKey,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              title: Text(
                local.signup_title,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter",
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: CustomTextFormField(
                            controller: cubit.firstNameController,
                            label: local.first_name,
                            hint: local.first_name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return local.first_name_required;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: CustomTextFormField(
                            controller: cubit.lastNameController,
                            label: local.last_name,
                            hint: local.last_name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return local.last_name_required;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: cubit.signUpEmailController,
                      label: local.email,
                      hint: local.enter_email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return local
                              .emailIsEmptyErrorMessage; // already exists
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: CustomTextFormField(
                            controller: cubit.signUpPasswordController,
                            label: local.password,
                            hint: local.password,
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
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: CustomTextFormField(
                            controller: cubit.signUpConfirmPasswordController,
                            label: local.confirm_password,
                            hint: local.confirm_password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return local.passwordRequiredErrorMsg;
                              }
                              if (cubit.signUpPasswordController.text !=
                                  cubit.signUpConfirmPasswordController.text) {
                                return local.password_mismatch;
                              }
                              if (!Validations.validatePassword(value)) {
                                return local.passwordValidationErrorMsg;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: cubit.phoneNumberController,
                      label: local.phone_number,
                      hint: local.enter_phone_number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return local.phone_number_required;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          local.gender,
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.grey,
                            fontWeight: FontWeight.w100,
                            fontFamily: "Inter",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Radio<String>(
                          value: "male",
                          groupValue: cubit.selectedGender,
                          onChanged: (value) => cubit.changeGender(value),
                          activeColor: AppColors.pink,
                        ),
                        Text(local.male),
                        Radio<String>(
                          value: "female",
                          groupValue: cubit.selectedGender,
                          onChanged: (value) => cubit.changeGender(value),
                          activeColor: AppColors.pink,
                        ),
                        Text(local.female),
                      ],
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(text: local.terms_prefix),
                          TextSpan(
                            text: local.terms_conditions,
                            style: const TextStyle(
                              color: AppColors.black,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    CustomElevatedButton(
                      onPressed: () {
                        if (cubit.selectedGender == null) {
                          showErrorMessage(context, local.gender_required);
                          return;
                        }
                        cubit.signUp(
                          selectedGender: cubit.selectedGender,
                          firstName: cubit.firstNameController.text,
                          lastName: cubit.lastNameController.text,
                          phoneNumber: cubit.phoneNumberController.text,
                          email: cubit.signUpEmailController.text,
                          password: cubit.signUpPasswordController.text,
                          confirmPassword:
                              cubit.signUpConfirmPasswordController.text,
                        );
                      },
                      text: local.signup_button,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.login);
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(text: local.already_have_account),
                            TextSpan(
                              text: " ${local.login}",
                              style: const TextStyle(
                                color: AppColors.pink,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
