import 'package:ai_photo_generator/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? back;
  final VoidCallback? onQuestionPressed, onback;
  final bool showQuestionIcon;
  final IconData icon;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.back,
    this.onQuestionPressed,
    this.onback,
    this.showQuestionIcon = false,
    this.icon = Icons.question_mark,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: 100.px,
      backgroundColor: AppColors.white,
      surfaceTintColor: AppColors.white,
      centerTitle: true,
      title: AppText(
        title,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        type: AppTextType.heading2,
      ),
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap:
            onback ??
            () {
              Get.back();
            },
        child: Row(
          children: [
            SizedBox(width: 2.w),
            Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.primary),
          ],
        ),
      ),
      actions: showQuestionIcon
          ? [
              GestureDetector(
                onTap: onQuestionPressed,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(icon, color: Colors.black),
                ),
              ),
              SizedBox(width: 2.w),
            ]
          : [],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Divider(
            height: 1,
            color: AppColors.hintTextGrey,
            thickness: 1,
          ),
        ),
      ),
    );
  }
}
