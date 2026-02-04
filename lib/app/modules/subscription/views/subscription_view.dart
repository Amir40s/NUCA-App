import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:nuca/widgets/custom_button.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          onPressed: () => Get.back(),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          icon: Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, size: 18, color: Colors.black),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppUtils.HorizontalPadding,
            vertical: AppUtils.VerticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(3.h),
              AppTextWidget(
                text: 'Nuca Premium',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              Gap(1.5.h),
              AppTextWidget(
                text: 'Access the most advanced AI research\nassistant',
                textAlign: TextAlign.center,
                fontSize: 18,
                color: Colors.black,
              ),
              Gap(4.h),
              _featureItem('Unlimited Scans'),
              _featureItem('No Ads'),
              _featureItem('Faster Results'),
              _featureItem('Extract Store Location'),
              _featureItem('And Much More...'),
              Gap(5.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 3.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.secondary),
                ),
                child: Column(
                  children: [
                    AppTextWidget(
                      text: 'Go Premium',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    Gap(1.5.h),
                    AppTextWidget(
                      text: '€5.99 / month',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    Gap(1.h),
                    AppTextWidget(text: 'Monthly Plan', fontSize: 16),
                  ],
                ),
              ),
              Gap(4.h),
              AppButtonWidget(
                onPressed: () {},
                text: "Subscribe Now",
                fontSize: 20,
                width: 100.w,
                radius: 30,
                textColor: Colors.white,
                fontWeight: FontWeight.w600,
                height: 7.h,
              ),
              Gap(3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _footerText('Terms of use'),
                  _divider(),
                  _footerText('Privacy Policy'),
                  _divider(),
                  _footerText('Restore'),
                ],
              ),
              Gap(2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(Assets.icons.check),
          Gap(3.w),
          AppTextWidget(text: text, fontSize: 16, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }

  Widget _footerText(String text) {
    return AppTextWidget(
      text: text,
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: AppTextWidget(
        text: '|',
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
