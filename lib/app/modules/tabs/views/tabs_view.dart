import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';
import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            controller.pages[controller.currentIndex.value],
            Positioned(left: 0, right: 0, bottom: 1.5.h, child: BottomNavBar()),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends GetView<TabsController> {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Center(
        child: SizedBox(
          width: 85.w,
          height: 10.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 9.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(40),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => controller.changeTab(0),
                      child: Obx(() {
                        final active = controller.currentIndex.value == 0;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.home,
                              size: 2.6.h,
                              color: active
                                  ? AppColors.black
                                  : AppColors.midGrey,
                            ),
                            const Gap(4),
                            AppTextWidget(
                              text: 'Home',
                              fontSize: 14,
                              color: active
                                  ? AppColors.black
                                  : AppColors.midGrey,
                            ),
                          ],
                        );
                      }),
                    ),
                    const Gap(60),
                    GestureDetector(
                      onTap: () => controller.changeTab(2),
                      child: Obx(() {
                        final active = controller.currentIndex.value == 2;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.user,
                              size: 2.6.h,
                              color: active
                                  ? AppColors.black
                                  : AppColors.midGrey,
                            ),
                            const Gap(4),
                            AppTextWidget(
                              text: 'Profile',
                              fontSize: 14,
                              color: active
                                  ? AppColors.black
                                  : AppColors.midGrey,
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -1.2.h,
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.SCAN_QR),
                  child: Container(
                    width: 8.5.h,
                    height: 8.5.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondary,
                      border: Border.all(
                        color: Colors.white.withAlpha(180),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.h),
                      child: SvgPicture.asset(
                        Assets.icons.qrCode,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
