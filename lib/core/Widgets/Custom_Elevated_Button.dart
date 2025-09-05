import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color; // Background color
  final Color? textColor; // Text color
  final Color? borderColor; // Outline/border color
  final double borderRadius; // Border radius
  final bool isLoading; // New loading flag

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.borderColor,
    this.borderRadius = 22.0,
    this.isLoading = false, // default to false
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 373,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.pink,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1.5,
            ),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor ?? AppColors.white,
                ),
              ),
      ),
    );
  }
}
