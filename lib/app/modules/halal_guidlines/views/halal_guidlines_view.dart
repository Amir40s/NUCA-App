import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:nuca/widgets/custom_appbar.dart';
import 'package:nuca/widgets/custom_button.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

import '../controllers/halal_guidlines_controller.dart';

class HalalGuidlinesView extends GetView<HalalGuidlinesController> {
  const HalalGuidlinesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "How we Decided Halal"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(2.h),
            Image.asset(
              Assets.images.halaImage.path,
              height: 22.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppUtils.HorizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(3.h),
                  AppTextWidget(
                    text: 'Our Verification Pillars',
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                  Gap(1.h),
                  AppTextWidget(
                    text:
                        'We use a rigorous multi-step process to verify the Halal status of every scanned product, cross-referencing with global standards from JAKIM, HMC, and IFANCA.',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.midGrey,
                  ),
                  Gap(3.h),
                  _PillarTile(
                    icon: "",
                    title: 'Ingredient Analysis',
                    description:
                        'Cross-referencing 50,000+ chemical names against prohibited lists.',
                  ),
                  Gap(1.8.h),
                  _PillarTile(
                    icon: Assets.icons.database,
                    title: 'E-Number Database',
                    description:
                        'Identifying hidden animal fats and synthetics in additives.',
                  ),
                  Gap(1.8.h),
                  _PillarTile(
                    icon: Assets.icons.alchole,
                    title: 'Alcohol Detection',
                    description:
                        'Detecting trace amounts and distinguishing natural vs added alcohol.',
                  ),
                  Gap(1.8.h),
                  _PillarTile(
                    icon: Assets.icons.varification,
                    title: 'Source Verification',
                    description:
                        'Strict slaughter method verification and species identification.',
                  ),
                  Gap(2.5.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondary),
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.secondary.withAlpha(80),
                    ),
                    child: AppTextWidget(
                      text:
                          '"Our database is updated daily. If you spot a discrepancy, please use the “Report” feature to help the community."',
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                  Gap(3.h),
                  AppButtonWidget(
                    onPressed: () {
                      Get.toNamed(Routes.SCAN_QR);
                    },
                    text: 'Start Scanning',
                    prefixIcon: SvgPicture.asset(Assets.icons.scanIcon),
                    fontSize: 20,
                    width: 100.w,
                    fontWeight: FontWeight.w600,
                    height: 7.h,
                    textColor: Colors.white,
                  ),
                  Gap(3.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PillarTile extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const _PillarTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon),
          Gap(3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(text: title, fontWeight: FontWeight.w600),
                Gap(0.6.h),
                AppTextWidget(
                  text: description,
                  fontWeight: FontWeight.w500,
                  color: AppColors.midGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
