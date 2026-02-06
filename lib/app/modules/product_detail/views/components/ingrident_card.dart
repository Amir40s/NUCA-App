import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/utils/export.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';

enum FoodStatus { halal, haram, unknown }

class HalalStatusCard extends StatelessWidget {
  final String status;
  const HalalStatusCard({super.key, required this.status});
  FoodStatus foodStatusFromString(String status) {
    switch (status.toLowerCase().trim()) {
      case 'halal':
      case 'Halal':
        return FoodStatus.halal;
      case 'haram':
      case 'Haram':
        return FoodStatus.haram;
      case 'Unknown':
      default:
        return FoodStatus.unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = getFoodStatusStyle(foodStatusFromString(status));

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: style.bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.midGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(style.icon, color: style.iconColor, size: 22),
              Gap(2.w),
              AppTextWidget(
                text: "Halal Status",
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 15,
              ),
            ],
          ),
          Gap(1.h),
          AppTextWidget(
            text:
                (status.toUpperCase().contains("MUSHBOOH") ||
                    status.toLowerCase() == "Unknown" ||
                    status.trim().isEmpty ||
                    status.contains("?") ||
                    status.toLowerCase() == "N/A")
                ? "Not Sure"
                : status,
            fontWeight: FontWeight.w600,
            color: style.textColor,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}

class NutritionScoreCard extends StatelessWidget {
  final String grade;
  final String iconPath;
  final String name;
  final String value;
  final String status;

  const NutritionScoreCard({
    super.key,
    required this.grade,
    required this.iconPath,
    required this.name,
    required this.value,
    required this.status,
  });
  FoodStatus foodStatusFromString(String status) {
    switch (status.toLowerCase().trim()) {
      case 'halal':
      case 'Halal':
        return FoodStatus.halal;
      case 'haram':
      case 'Haram':
        return FoodStatus.haram;
      case 'Unknown':
      default:
        return FoodStatus.unknown;
    }
  }

  Color get gradeColor {
    final value = grade.toUpperCase();

    switch (value) {
      case 'A':
      case '1':
        return AppColors.secondary;

      case 'B':
      case '2':
        return AppColors.secondary;

      case 'C':
      case '3':
        return Colors.orange.shade400;

      case 'D':
      case '4':
        return Colors.orange.shade700;

      case 'E':
      case '5':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = getFoodStatusStyle(foodStatusFromString(status));
    final isUnknown =
        grade.isEmpty ||
        grade == "Unknown" ||
        grade.toLowerCase() == "unknown" ||
        grade.toUpperCase() == "UNKNOWN" ||
        grade.contains("?") ||
        grade.trim().isEmpty;
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: isUnknown ? Color(0xFFE6E4DC) : AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.midGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(style.textColor, BlendMode.srcIn),
              ),
              Gap(2.w),
              Expanded(
                child: AppTextWidget(
                  text: name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Gap(1.h),
          Row(
            children: [
              AppTextWidget(
                text: isUnknown ? "?" : value,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 18,
              ),
              if (!isUnknown) const Spacer(),
              if (!isUnknown)
                Container(
                  width: 6.w,
                  height: 6.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: gradeColor,
                    shape: BoxShape.circle,
                  ),
                  child: AppTextWidget(
                    text: grade.toUpperCase(),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String iconPath;
  final String status;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.iconPath,
    required this.status,
  });
  FoodStatus foodStatusFromString(String status) {
    switch (status.toLowerCase().trim()) {
      case 'halal':
      case 'Halal':
        return FoodStatus.halal;
      case 'haram':
      case 'Haram':
        return FoodStatus.haram;
      case 'Unknown':
      default:
        return FoodStatus.unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = getFoodStatusStyle(foodStatusFromString(status));

    double? numericValue;
    final match = RegExp(r'^-?\d+(\.\d+)?').firstMatch(value);
    if (match != null) {
      numericValue = double.tryParse(match.group(0)!);
    }

    final isUnknown =
        value.isEmpty ||
        value.toLowerCase() == "unknown" ||
        value.contains("?") ||
        (numericValue != null && numericValue == 0);

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: isUnknown ? Color(0xFFE6E4DC) : AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.midGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(style.textColor, BlendMode.srcIn),
              ),
              Gap(2.w),
              AppTextWidget(
                text: title,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ],
          ),
          Gap(1.h),
          AppTextWidget(
            text: isUnknown ? "?" : value,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}

class FoodStatusStyle {
  final Color bgColor;
  final Color textColor;
  final Color iconColor;
  final IconData icon;

  FoodStatusStyle({
    required this.bgColor,
    required this.textColor,
    required this.iconColor,
    required this.icon,
  });
}

FoodStatusStyle getFoodStatusStyle(FoodStatus status) {
  switch (status) {
    case FoodStatus.halal:
      return FoodStatusStyle(
        bgColor: const Color(0xFFCDEED6),
        textColor: AppColors.secondary,
        iconColor: AppColors.secondary,
        icon: Icons.check_circle,
      );
    case FoodStatus.haram:
      return FoodStatusStyle(
        bgColor: const Color(0xFFFFD6D1),
        textColor: const Color(0xFFB42318),
        iconColor: const Color(0xFFB42318),
        icon: Icons.cancel,
      );
    case FoodStatus.unknown:
      return FoodStatusStyle(
        bgColor: const Color(0xFFE6E4DC),
        textColor: Colors.black54,
        iconColor: Colors.black54,
        icon: Icons.help,
      );
  }
}
