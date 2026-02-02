import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:nuca/app/utils/app_assets.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:nuca/app/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';

class LanguageTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final IconData icon;
  final VoidCallback onTap;

  const LanguageTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.black),
        ),
        child: Row(
          children: [
            SvgPicture.asset(isSelected ? AppAssets.tick : AppAssets.circle),
            Gap(2.w),
            Icon(icon, color: AppColors.textSecondary),
            Gap(2.w),
            Expanded(
              child: AppTextWidget(
                text: title,
                fontSize: 20.px,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
