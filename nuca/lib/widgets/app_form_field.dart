import 'package:ai_photo_generator/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppFormField extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool isObsecured;
  final VoidCallback? onTap;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final bool isMultiline;
  final bool readOnly;
  final int? wordCount, maxLength;
  final bool showBorder;
  final Color? focusedBorderColor, borderColor;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const AppFormField({
    super.key,
    required this.title,
    this.icon,
    this.isObsecured = false,
    this.readOnly = false,
    this.onTap,
    required this.textEditingController,
    this.validator,
    this.textInputType = TextInputType.text,
    this.isMultiline = false,
    this.wordCount,
    this.borderColor,
    this.maxLength,
    this.showBorder = false,
    this.focusedBorderColor,
    this.focusNode,
    this.textInputAction,
  });

  String? _validateWordCount(String? value) {
    if (wordCount != null && value != null && value.trim().isNotEmpty) {
      final words = value.trim().split(RegExp(r'\s+'));
      if (words.length > wordCount!) {
        return 'Maximum $wordCount words allowed';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: isMultiline ? TextInputType.multiline : textInputType,
      validator: (value) {
        final baseValidation = validator?.call(value);
        final wordLimitValidation = _validateWordCount(value);
        return baseValidation ?? wordLimitValidation;
      },
      readOnly: readOnly,
      maxLength: maxLength,
      controller: textEditingController,
      obscureText: isObsecured,
      maxLines: isMultiline ? 5 : 1,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        filled: true,
        hintText: title,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        fillColor: AppColors.hintTextGrey.withValues(alpha: 0.2),
        border: showBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: borderColor ?? Colors.grey.shade400,
                  width: 1,
                ),
              )
            : InputBorder.none,

        enabledBorder: showBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: borderColor ?? Colors.grey.shade400,
                  width: 1,
                ),
              )
            : InputBorder.none,

        focusedBorder: showBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: focusedBorderColor ?? AppColors.primary,
                  width: 1.2,
                ),
              )
            : InputBorder.none,

        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(icon, size: 25.px, color: AppColors.primary),
        ),
      ),
    );
  }
}
