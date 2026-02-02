import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:nuca/app/modules/on_boarding/views/components/on_boarding_widget.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:nuca/app/utils/app_utils.dart';
import 'package:nuca/app/widgets/app_text_widget.dart';
import 'package:nuca/app/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppUtils.HorizontalPadding,
            vertical: AppUtils.VerticalPadding,
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  children: const [
                    OnBoardingWidget(
                      image: 'assets/images/onboarding_1.png',
                      title: 'Scan Any Food',
                      subtitle:
                          'Scan supermarket products using\nbarcaroles and get instant food details\nHalal status, and prices.',
                    ),
                    OnBoardingWidget(
                      image: 'assets/images/onboarding_2.png',
                      title: 'Halal Status Made Clear',
                      subtitle:
                          'Instant Halal, Haram, or Not Sure results\nwith clear explanations for every\ningredient.',
                    ),
                  ],
                ),
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: controller.currentIndex.value == index ? 10 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: controller.currentIndex.value == index
                            ? Colors.green
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Gap(3.h),
              AppButtonWidget(
                onPressed: () {
                  // Get.toNamed(Routes.SELECT_PREFERENCES);
                },
                text: controller.currentIndex.value == 1
                    ? 'Scan first card'
                    : 'Next',
                fontSize: 20,
                width: 100.w,
                fontWeight: FontWeight.w600,
                height: 7.h,
              ),
              Gap(1.h),
              const SizedBox(height: 16),
              Obx(() {
                return controller.currentIndex.value == 0
                    ? TextButton(
                        onPressed: () {},
                        child: const AppTextWidget(
                          text: "Skip",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          AppTextWidget(text: "Don't have an account? "),
                          AppTextWidget(
                            text: "Login",
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
