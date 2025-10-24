import 'package:flutter/material.dart';
import 'package:users_dvp_app/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String? placeholder;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;
  final Icon? startIcon;
  final Icon? endIcon;
  final TextInputType typeKeyboard;
  final bool isReadOnly;
  final TextEditingController? controller;
  final String? prefixText;
  final String? errorMessage;
  final String? initialValue;
  final bool autofocus;
  final FocusNode? focusNode;
  const CustomTextField({
    super.key,
    required this.title,
    this.placeholder,
    this.startIcon,
    this.endIcon,
    this.maxLines,
    this.maxLength,
    this.onTap,
    this.typeKeyboard = TextInputType.text,
    this.isReadOnly = false,
    this.controller,
    this.prefixText,
    this.onChanged,
    this.errorMessage,
    this.initialValue,
    this.autofocus = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      obscureText: false,
      keyboardType: typeKeyboard,
      onTap: onTap,
      readOnly: isReadOnly,
      decoration: InputDecoration(
        prefixText: prefixText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.accent)),
        focusColor: AppColors.accent,
        border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(9.0))),
        labelText: title,
        hintText: placeholder,
        prefixIcon: startIcon,
        errorText: errorMessage,
        suffixIcon: endIcon,
      ),
      autofocus: autofocus,
      focusNode: focusNode,
    );
  }
}
