import 'package:another_flushbar/flushbar.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'custom_toast.dart';

Future<void> showCustomSnackBar(BuildContext context, String? message,
    {bool isError = true,
    bool isWarning = false,
    bool showToaster = false}) async {
  if (message == null || message.isEmpty) return;

  if (isWarning) {
    Flushbar(
      titleText: Text(
        isError ? 'warning' : 'success!',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 16,
        ),
      ),
      messageText: Text(message, style: const TextStyle(color: AppColors.grey)),
      icon: Icon(
        isError ? Icons.warning_amber_rounded : Icons.check_circle,
        size: 32,
        color: isError ? AppColors.red : AppColors.green,
      ),
      borderColor: AppColors.grey.withValues(alpha: 0.15),
      margin: const EdgeInsets.all(6.0),
      backgroundColor: AppColors.grey.withValues(alpha: 0.2),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.BOTTOM,
      textDirection: Directionality.of(context),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: isError ? AppColors.pink : Colors.green,
    ).show(context);
  } else {
    if (showToaster && !GetPlatform.isWeb) {
      await Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isError ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontAsset: message.toLowerCase().contains("sar")
            ? "assets/font/sar-Regular.otf"
            : null,
        fontSize: 12,
        webShowClose: true,
        webPosition: "left",
      );
    } else {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(
          dismissDirection: DismissDirection.endToStart,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          content: CustomToast(text: message, isError: isError),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ));
    }
  }
}
