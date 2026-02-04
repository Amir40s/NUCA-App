import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nuca/app/modules/select_preferences/views/components/picker_tile.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:nuca/widgets/custom_button.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

import '../controllers/select_preferences_controller.dart';

class SelectPreferencesView extends GetView<SelectPreferencesController> {
  const SelectPreferencesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppUtils.HorizontalPadding,
            vertical: AppUtils.VerticalPadding,
          ),
          child: Column(
            children: [
              Gap(2.h),
              AppTextWidget(
                text: "Set your Preferences",
                fontSize: 22.px,
                textAlign: .start,
                fontWeight: FontWeight.w600,
              ),
              Gap(1.h),
              AppTextWidget(
                text:
                    "To provide accurate Halal status based on\nlocal regulations and compare grocery prices",
                textAlign: TextAlign.center,
              ),
              Gap(4.h),
              Align(
                alignment: Alignment.centerLeft,
                child: AppTextWidget(
                  text: "Select Country",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Gap(1.h),
              Obx(
                () => PickerTile(
                  title: "Choose your Country",
                  icon: Assets.icons.person,
                  value: controller.selectedCountry.value,
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        controller.setCountry(country.name);
                      },
                    );
                  },
                ),
              ),
              Gap(4.h),
              Align(
                alignment: Alignment.centerLeft,
                child: AppTextWidget(
                  text: "Select Currency",
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Gap(1.h),
              Obx(
                () => PickerTile(
                  title: "e.g. ( € )",
                  icon: Assets.icons.coin,
                  value: controller.selectedCurrency.value,
                  onTap: () {
                    showCurrencyPicker(
                      context: context,
                      theme: CurrencyPickerThemeData(
                        backgroundColor: Colors.white,
                        titleTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        subtitleTextStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      onSelect: (currency) {
                        controller.setCurrency(
                          "${currency.code} (${currency.symbol})",
                        );
                      },
                    );
                  },
                ),
              ),
              Gap(2.h),
              Row(
                children: [
                  SvgPicture.asset(Assets.icons.info),
                  Gap(2.w),
                  Expanded(
                    child: AppTextWidget(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      text:
                          "You can update these preference anytime in your profile settings.",
                    ),
                  ),
                ],
              ),
              Gap(4.h),
              Obx(() {
                final isValid =
                    controller.selectedCountry.value.isNotEmpty &&
                    controller.selectedCurrency.value.isNotEmpty;
                return AppButtonWidget(
                  onPressed: () {
                    if (isValid) {
                      Get.toNamed(Routes.ON_BOARDING);
                    } else {
                      AppUtils.showMessage(
                        isError: true,

                        "Please select both country and currency.",
                        context: context,
                      );
                    }
                  },
                  text: "Continue",
                  fontSize: 20,
                  width: 100.w,
                  fontWeight: FontWeight.w600,
                  height: 7.h,
                );
              }),
              Gap(1.h),
            ],
          ),
        ),
      ),
    );
  }
}
