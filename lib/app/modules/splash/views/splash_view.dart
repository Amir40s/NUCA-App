import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:nuca/utils/export.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final controller = Get.put(SplashController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppUtils.HorizontalPadding,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Assets.icons.appIcon.path, height: 20.h),
              Gap(2.h),
              AppTextWidget(
                text: "Nuca",
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
              Gap(2.h),
              AppTextWidget(
                text: "Food Scan.Halal Check.Best Price",
                fontSize: 18,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
