import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nuca/app/modules/on_boarding/views/components/on_boarding_widget.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:nuca/widgets/custom_button.dart';
import 'package:nuca/gen/assets.gen.dart';
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
                  children: [
                    OnBoardingWidget(
                      image: Assets.icons.onBoarding1,
                      title: 'Scan Any Food',
                      subtitle:
                          'Scan supermarket products using barcodes and get instant food details, Halal status, and prices.',
                    ),
                    OnBoardingWidget(
                      image: Assets.icons.onBoarding2,
                      title: 'Halal Status Made Clear',
                      subtitle:
                          'Instant Halal, Haram, or Not Sure results with clear explanations for every ingredient.',
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
              Gap(3.h),
              Obx(
                () => AppButtonWidget(
                  onPressed: () {
                    controller.nextPage();
                  },
                  text: controller.currentIndex.value == 1
                      ? 'Scan first card'
                      : 'Next',
                  fontSize: 20,
                  width: 100.w,
                  fontWeight: FontWeight.w600,
                  height: 7.h,
                ),
              ),
              Gap(1.h),
              const SizedBox(height: 16),
              Obx(() {
                return controller.currentIndex.value == 0
                    ? TextButton(
                        onPressed: () {
                          Get.offAllNamed(
                            Routes.HOME,
                            arguments: {"showBottomSheet": true},
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const AppTextWidget(
                          text: "Skip",
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.LOGIN);
                            },
                            child: const AppTextWidget(
                              text: "Don't have an account? ",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.SIGN_UP);
                            },
                            child: const AppTextWidget(
                              text: "Sign Up",
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
