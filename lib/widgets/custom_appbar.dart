import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final bool showBack;
  final bool showShare;
  final Color backgroundColor;
  final Color titleColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.showBack = true,
    this.backgroundColor = AppColors.backgroundColor,
    this.titleColor = Colors.black,
    this.showShare = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: backgroundColor,
      elevation: 0,
      centerTitle: true,
      leading: showBack
          ? IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 3.h),
            )
          : null,
      title: AppTextWidget(
        text: title,
        color: titleColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
      actions: [
        if (showShare == true)
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.share, color: Colors.black, size: 3.h),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
