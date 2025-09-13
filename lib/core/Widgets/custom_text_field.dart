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
  final bool obscureText; // formerly isPassword
  final TextInputType keyboardType;
  final bool enabled;
  final bool readonly;
  final String? initialText;

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
      style: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      cursorColor: AppColors.pink,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.pink, width: 1.5),
        ),
        labelText: widget.label,
        labelStyle: TextStyle(
          color: AppColors.black,
          fontWeight: FontWeight.w400,

        ),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: AppColors.grey.withValues(alpha: 0.5),
        ),
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
            : null,
        suffix: widget.suffixText != null
            ? GestureDetector(
          onTap: widget.onPressed ?? () {},
          child: Text(
            widget.suffixText!,
            style: TextStyle(
              color: AppColors.pink,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        )
            : null,
        border: const OutlineInputBorder(),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black),
        ),
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}