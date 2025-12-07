import 'package:flower_app/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../../../../core/contants/app_images.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/routes/route_names.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../viewmodel/states/verify_code_states.dart';
import '../../viewmodel/verify_code_viewmodel.dart';
import '../widgets/verification_code_field.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  const EmailVerificationScreen({super.key, required this.email});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.email != "") {
      context.read<VerifyCodeCubit>().setEmail(widget.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Image.asset(AppImages.arrowBack),
        ),
        title: Text(local.password),
      ),
      body: BlocConsumer<VerifyCodeCubit, VerifyCodeStates>(
        listener: (context, state) {
          if (state is VerifyCodeSuccessStates) {
            Navigator.pushNamed(
              context,
              AppRoutes.resetPassword,
              arguments: widget.email,
            );
          } else if (state is VerifyCodeErrorStates) {
            showCustomSnackBar(context, state.message, isError: true);
          }
        },
        builder: (context, state) {
          final cubit = context.watch<VerifyCodeCubit>();

          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    local.emailVerificationScreen,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    local.emailVerificationScreenUnderMsg,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  const VerificationCodeField(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        local.codeReceiveMsgError,
                        style: const TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: cubit.isResendEnabled
                            ? () => cubit.resendCode()
                            : null,
                        child: Text(
                          cubit.isResendEnabled ? local.resend : local.resend,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 17,
                            color: cubit.isResendEnabled
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                  state is VerifyCodeLoadingStates
                      ? const SizedBox(
                          height: 50,
                          width: 50,
                          child: LoadingIndicator(
                            indicatorType: Indicator.lineScalePulseOut,
                            colors: [AppColors.pink],
                            strokeWidth: 2,
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      : CustomElevatedButton(
                          text: local.nextButton,
                          onPressed: cubit.enteredCode.length == 6
                              ? () {
                                  cubit.verify(context);
                                }
                              : null,
                        ),
                ],
              ).setVerticalPadding(context, 0.04),
            ),
          );
        },
      ),
    );
  }
}
