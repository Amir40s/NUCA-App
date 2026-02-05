import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/app/routes/app_pages.dart';
import '/services/shared_preferences_service.dart';
import '/utils/app_colors.dart';
import '/widgets/app_text_widget.dart';
import '/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

class HomeCards extends StatelessWidget {
  const HomeCards({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withAlpha(50),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SvgPicture.asset(Assets.icons.barChart),
                      ),
                      AppTextWidget(
                        text: 'Monthly',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.midGrey,
                      ),
                    ],
                  ),
                  Gap(2.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${SharedPreferencesService.perMonthScans} / ',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '${SharedPreferencesService.totalScans}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(1.h),
                  AppTextWidget(
                    text: 'Scan Left',
                    fontSize: 16,
                    color: AppColors.midGrey,
                  ),
                  Gap(1.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 1.h,
                      backgroundColor: AppColors.lightGrey,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(4.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppColors.darkGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SvgPicture.asset(Assets.icons.crown),
                      ),
                      Gap(9.5.w),
                      AppTextWidget(
                        text: 'Pro',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.midGrey,
                      ),
                    ],
                  ),
                  Gap(1.5.h),
                  AppTextWidget(
                    text: 'Go Premium',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  Gap(0.5.h),
                  AppTextWidget(
                    text: 'Unlimited scans & deals',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  Gap(1.5.h),
                  SizedBox(
                    width: Get.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.SUBSCRIPTION);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: AppTextWidget(
                        text: 'Upgrade',
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
