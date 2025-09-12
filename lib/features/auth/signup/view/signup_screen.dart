import 'package:flower_app/core/Widgets/Custom_Elevated_Button.dart';
import 'package:flower_app/core/Widgets/custom_text_field.dart';
import 'package:flower_app/core/Widgets/messages/messages_methods.dart';
import 'package:flower_app/core/config/di.dart';
import 'package:flower_app/core/extensions/validations.dart';
import 'package:flower_app/core/l10n/translation/app_localizations.dart';
import 'package:flower_app/core/routes/route_names.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/auth/signup/cubit/signup_cubit.dart';
import 'package:flower_app/features/auth/signup/cubit/signup_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
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
        } else if (state is SignupSuccessState) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
          showSuccessMessage(context, "created successfully");
        } else if (state is SignupErrorState) {
          Navigator.pop(context);
          showErrorMessage(context, state.errorMessage);
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
                "Sign up",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                    fontStyle: FontStyle.normal),
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
                            label: "First name",
                            hint: "First name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "First name is required";
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
                            label: "Last name",
                            hint: "Last name",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Last name is required";
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
                      label: "Email",
                      hint: "Enter your email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return local!.emailIsEmptyErrorMessage;
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
                            label: "Password",
                            hint: "Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return local!.passwordRequiredErrorMsg;
                              }
                              if (!Validations.validatePassword(value)) {
                                return local!.passwordValidationErrorMsg;
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
                            label: "Confirm Password",
                            hint: "Confirm Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return local!.passwordRequiredErrorMsg;
                              }
                              if (cubit.signUpPasswordController.text !=
                                  cubit.signUpConfirmPasswordController.text) {
                                return "Password does not match";
                              }
                              if (!Validations.validatePassword(value)) {
                                return local!.passwordValidationErrorMsg;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      controller: cubit.phoneNumberController,
                      label: "Phone number",
                      hint: "Enter phone number",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone number is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
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
                        const Text(
                          "Male",
                          style: TextStyle(
                            fontSize: 17,
                            color: AppColors.black,
                            fontWeight: FontWeight.w100,
                            fontFamily: "Inter",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Radio<String>(
                          value: "female",
                          groupValue: cubit.selectedGender,
                          onChanged: (value) => cubit.changeGender(value),
                          activeColor: AppColors.pink,
                        ),
                        const Text(
                          "Female",
                          style: TextStyle(
                            fontSize: 17,
                            color: AppColors.black,
                            fontWeight: FontWeight.w100,
                            fontFamily: "Inter",
                            fontStyle: FontStyle.normal,
                          ),
                        ),
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
                          const TextSpan(
                              text: "Creating an account, you agree to our "),
                          TextSpan(
                            text: "Terms & Conditions",
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
                            showErrorMessage(context, "Gender is required");
                            return;
                          } //! Check if gender is selected or no "Validation"

                          cubit.signUp(
                              selectedGender: cubit.selectedGender,
                              firstName: cubit.firstNameController.text,
                              lastName: cubit.lastNameController.text,
                              phoneNumber: cubit.phoneNumberController.text,
                              email: cubit.signUpEmailController.text,
                              password: cubit.signUpPasswordController.text,
                              confirmPassword:
                                  cubit.signUpConfirmPasswordController.text);
                        },
                        text: "Sign up"),
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
                            const TextSpan(text: "Already have an account?"),
                            TextSpan(
                              text: " Login",
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
