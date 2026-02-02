import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:nuca/app/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';

class ScannedFoodCard extends StatelessWidget {
  final String image;
  final String title;
  final String time;
  final String price;
  final bool isHalal;

  const ScannedFoodCard({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.price,
    required this.isHalal,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isHalal
        ? const Color(0xFFB7E3BC)
        : const Color(0xFFFFD6CC);
    final Color badgeColor = isHalal
        ? const Color(0xFF7ED49A)
        : const Color(0xFFFFA59A);
    final Color iconColor = isHalal
        ? const Color(0xFF0E7A3B)
        : const Color(0xFFD32F2F);

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              image,
              width: 16.w,
              height: 16.w,
              fit: BoxFit.cover,
            ),
          ),
          Gap(4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                  text: title,
                  fontSize: 16,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                Gap(1.h),
                AppTextWidget(
                  text: '$time  ·  €$price',
                  fontSize: 14,
                  color: AppColors.midGrey,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Gap(3.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.9.h),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Icon(
                    isHalal ? Icons.check_circle : Icons.cancel,
                    color: iconColor,
                    size: 14,
                  ),
                  Gap(1.w),
                  AppTextWidget(
                    text: isHalal ? 'Halal' : 'Haram',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
