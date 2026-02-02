import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/export.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? initialValue;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;
  final bool enabled;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final Color? fillColor;
  final Color? cursorColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextAlign textAlign;
  final bool isOutlineBorder;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.initialValue,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.enabled = true,
    this.textInputAction,
    this.focusNode,
    this.contentPadding,
    this.borderRadius,
    this.fillColor,
    this.cursorColor,
    this.style,
    this.hintStyle,
    this.textAlign = TextAlign.start,
    this.isOutlineBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      enabled: enabled,
      textInputAction: textInputAction,
      focusNode: focusNode,
      style: style,
      textAlign: textAlign,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        border: isOutlineBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular((borderRadius ?? 12).sp),
                borderSide: BorderSide(color: AppColors.borderColor),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 12),
                borderSide: BorderSide.none,
              ),
        focusedBorder: isOutlineBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular((borderRadius ?? 12).sp),
                borderSide: BorderSide(color: AppColors.borderColor),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular((borderRadius ?? 12).sp),
                borderSide: BorderSide.none,
              ),
        enabledBorder: isOutlineBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular((borderRadius ?? 12).sp),
                borderSide: BorderSide(color: AppColors.borderColor),
              )
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular((borderRadius ?? 12).sp),
                borderSide: BorderSide.none,
              ),
      ),
      cursorColor: cursorColor ?? AppColors.white,
    );
  }
}
