import 'package:flutter/material.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:nuca/utils/app_colors.dart';

class EmptyWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyWidget({
    super.key,
    this.message = "No data available",
    this.icon = Icons.inbox,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20.w, color: AppColors.midGrey),
          SizedBox(height: 2.h),
          AppTextWidget(
            text: message,
            textAlign: TextAlign.center,
            fontSize: 16,
            color: AppColors.midGrey,
          ),
        ],
      ),
    );
  }
}
