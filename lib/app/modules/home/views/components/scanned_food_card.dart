import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';

class ScannedFoodCard extends StatelessWidget {
  final String image;
  final String title;
  final String time;
  final String price;
  final String isHalal;

  const ScannedFoodCard({
    super.key,
    required this.image,
    required this.title,
    required this.time,
    required this.price,
    required this.isHalal,
  });

  bool get isHalalStatus => isHalal.toUpperCase() == "HALAL";
  bool get isHaramStatus => isHalal.toUpperCase() == "HARAM";
  bool get isNotSureStatus => !isHalalStatus && !isHaramStatus;
  @override
  Widget build(BuildContext context) {
    final bool halal = isHalal.toUpperCase() == "HALAL";
    final bool haram = isHalal.toUpperCase() == "HARAM";

    final Color bgColor = halal
        ? const Color(0xFFB7E3BC)
        : haram
        ? const Color(0xFFFFD6CC)
        : const Color(0xFFFFF3CD); // Not sure

    final Color badgeColor = halal
        ? const Color(0xFF7ED49A)
        : haram
        ? const Color(0xFFFFA59A)
        : const Color(0xFFFFE08A);

    final Color iconColor = halal
        ? const Color(0xFF0E7A3B)
        : haram
        ? const Color(0xFFD32F2F)
        : const Color(0xFF856404);

    final IconData statusIcon = halal
        ? Icons.check_circle
        : haram
        ? Icons.cancel
        : Icons.help_outline;

    final String statusText = halal
        ? "Halal"
        : haram
        ? "Haram"
        : "Not Sure";

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
            child: Image.network(
              image,
              width: 16.w,
              height: 16.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 16.w,
                  height: 16.w,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 24,
                  ),
                );
              },
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
                  Icon(statusIcon, color: iconColor, size: 14),
                  Gap(1.w),
                  AppTextWidget(
                    text: statusText,
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
