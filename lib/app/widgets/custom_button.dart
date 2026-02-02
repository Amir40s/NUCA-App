import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/export.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Widget? leading;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.color,
    this.textStyle,
    this.padding,
    this.borderRadius,
    this.leading,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 5.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.accentDark,
          padding:
              padding ??
              EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular((borderRadius ?? 12).sp),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 8)],
            if (isLoading)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            else
              AppTextWidget(
                text: label,
                color: textStyle?.color ?? Colors.white,
                fontWeight: textStyle?.fontWeight ?? FontWeight.w600,
                fontSize: textStyle?.fontSize ?? 14,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
