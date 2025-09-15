import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../viewmodel/states/verify_code_states.dart';
import '../../viewmodel/verify_code_viewmodel.dart';

class VerificationCodeField extends StatelessWidget {
  const VerificationCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    final theme = Theme.of(context).textTheme;
    final state = context.watch<VerifyCodeCubit>().state;
    final cubit = context.read<VerifyCodeCubit>();

    return Column(
      children: [
        OtpTextField(
          numberOfFields: 6,
          fieldWidth: 57,
          fieldHeight: 60,
          borderRadius: BorderRadius.circular(8),
          borderColor:
              state is VerifyCodeErrorStates ? Colors.red : Colors.grey,
          focusedBorderColor:
              state is VerifyCodeErrorStates ? Colors.red : Colors.blue,
          filled: true,
          fillColor: state is VerifyCodeErrorStates
              ? Colors.red.withOpacity(0.2)
              : AppColors.white[60]!,
          showFieldAsBox: true,
          onSubmit: (code) => cubit.updateCode(code),
          onCodeChanged: (code) => cubit.updateCode(code),
        ),
        if (state is VerifyCodeErrorStates)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              local.wrongPasswordErrorMsg,
              style: theme.bodySmall?.copyWith(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
