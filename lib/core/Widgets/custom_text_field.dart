import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onPressed;
  final String? label;
  final String? hint;
  final String? suffixText;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool enabled;
  final bool readonly;
  final String? initialText;
  final double borderRadius;
  final Widget? prefixIcon;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.onPressed,
    this.label,
    this.hint,
    this.suffixText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.readonly = false,
    this.initialText,
    this.borderRadius = 8.0,
    this.prefixIcon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isTextObscured;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    isTextObscured = widget.obscureText;
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      enabled: widget.enabled,
      readOnly: widget.readonly,
      obscureText: isTextObscured,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      cursorColor: AppColors.pink,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.pink, width: 1.5),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.black),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        labelText: widget.label,
        labelStyle: const TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w400,
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: AppColors.grey.withValues(alpha: 0.5),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            isTextObscured ? Icons.visibility_off : Icons.visibility,
            color: AppColors.grey,
          ),
          onPressed: () {
            setState(() {
              isTextObscured = !isTextObscured;
            });
          },
        )
            : (widget.suffixText != null
            ? GestureDetector(
          onTap: widget.onPressed ?? () {},
          child: Text(
            widget.suffixText!,
            style: const TextStyle(
              color: AppColors.pink,
              fontWeight: FontWeight.w600,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        )
            : null),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}
