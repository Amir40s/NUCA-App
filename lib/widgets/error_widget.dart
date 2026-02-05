import 'package:flutter/material.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';

class ErrorRetryWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorRetryWidget({
    super.key,
    this.message = "Something went wrong",
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18.w, color: Colors.redAccent),
          SizedBox(height: 2.h),
          AppTextWidget(
            text: message,
            textAlign: TextAlign.center,
            fontSize: 16,
            color: Colors.redAccent,
          ),
          if (onRetry != null) ...[
            SizedBox(height: 2.h),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
              ),
              child: const AppTextWidget(text: "Retry"),
            ),
          ],
        ],
      ),
    );
  }
}
