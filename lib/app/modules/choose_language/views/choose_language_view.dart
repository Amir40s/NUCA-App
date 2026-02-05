import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/widgets/custom_appbar.dart';
import 'package:nuca/widgets/custom_button.dart';
import '/app/modules/choose_language/views/components/language_tile.dart';
import '../../../../utils/app_utils.dart';
import '../../../../widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';
import '../controllers/choose_language_controller.dart';

class ChooseLanguageView extends GetView<ChooseLanguageController> {
  const ChooseLanguageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: controller.showBack == true ? CustomAppBar(title: "") : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppUtils.HorizontalPadding,
            vertical: AppUtils.VerticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(2.h),
              AppTextWidget(
                text: "Choose your Language",
                fontSize: 22.px,
                textAlign: .start,
                fontWeight: FontWeight.w600,
              ),
              Gap(1.h),
              AppTextWidget(
                text:
                    "This will help us personalize your food\nscanning experience and provide accurate\nHalal Data.",
                textAlign: TextAlign.center,
              ),
              Gap(2.h),
              Obx(
                () => LanguageTile(
                  title: "العربية",
                  icon: Icons.translate,
                  isSelected: controller.isSelected("العربية"),
                  onTap: () => controller.changeLanguage("العربية"),
                ),
              ),
              Obx(
                () => LanguageTile(
                  title: "English",
                  icon: Icons.public,
                  isSelected: controller.isSelected("English"),
                  onTap: () => controller.changeLanguage("English"),
                ),
              ),
              Obx(
                () => LanguageTile(
                  title: "Francais",
                  icon: Icons.translate,
                  isSelected: controller.isSelected("Francais"),
                  onTap: () => controller.changeLanguage("Francais"),
                ),
              ),
              Obx(
                () => LanguageTile(
                  title: "Deutsch",
                  icon: Icons.public,
                  isSelected: controller.isSelected("Deutsch"),
                  onTap: () => controller.changeLanguage("Deutsch"),
                ),
              ),
              Obx(
                () => LanguageTile(
                  title: "Nederlands",
                  icon: Icons.translate,
                  isSelected: controller.isSelected("Nederlands"),
                  onTap: () => controller.changeLanguage("Nederlands"),
                ),
              ),
              Gap(3.h),
              AppButtonWidget(
                onPressed: () {
                  Get.toNamed(Routes.SELECT_PREFERENCES);
                },
                text: "Continue",
                fontSize: 20,
                width: 100.w,
                fontWeight: FontWeight.w600,
                height: 7.h,
              ),
              Gap(3.h),
            ],
          ),
        ),
      ),
    );
  }
}
