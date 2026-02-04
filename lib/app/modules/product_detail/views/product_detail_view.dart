import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nuca/app/modules/product_detail/views/components/ingrident_card.dart';
import 'package:nuca/app/modules/product_detail/views/components/near_shops_card.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:nuca/widgets/custom_appbar.dart';
import 'package:nuca/widgets/custom_button.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Product Details", showShare: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppUtils.HorizontalPadding,
            vertical: AppUtils.VerticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.midGrey),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        Assets.images.food1.path,
                        width: 28.w,
                        height: 28.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Gap(4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextWidget(
                            text: 'Chocolate Biscuit',
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          Gap(1.h),
                          AppTextWidget(
                            text: 'Brand: Sweet Co International',
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            color: AppColors.midGrey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Gap(2.5.h),
              AppTextWidget(
                text: 'Product Information',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              Gap(2.5.h),
              infoRow(
                HalalStatusCard(status: FoodStatus.halal),
                NutritionScoreCard(
                  grade: 'B',
                  iconPath: Assets.icons.nutrationScore,
                  name: 'Nutrition Score',
                  value: 'Grade B',
                ),
              ),
              Gap(2.h),
              infoRow(
                InfoCard(
                  title: 'Energy',
                  value: '265 Kcal',
                  iconPath: Assets.icons.energy,
                ),
                InfoCard(
                  title: 'Sugar',
                  value: '4g',
                  iconPath: Assets.icons.sugar,
                ),
              ),
              Gap(2.h),
              infoRow(
                InfoCard(
                  title: 'Salt',
                  value: '1.2g',
                  iconPath: Assets.icons.salt,
                ),
                InfoCard(
                  title: 'Carbs',
                  value: '32g',
                  iconPath: Assets.icons.carbs,
                ),
              ),
              Gap(2.h),
              infoRow(
                InfoCard(
                  title: 'GMO / OGM',
                  value: 'Non-GMO',
                  iconPath: Assets.icons.gmo,
                ),
                InfoCard(
                  title: 'Bio Status',
                  value: 'Organic',
                  iconPath: Assets.icons.bio,
                ),
              ),
              Gap(2.h),
              infoRow(
                InfoCard(
                  title: 'Proteins',
                  value: '12g',
                  iconPath: Assets.icons.protiens,
                ),
                NutritionScoreCard(
                  name: 'Additives Status',
                  value: 'Nova 1',
                  iconPath: Assets.icons.addictiveStatus,
                  grade: '1',
                ),
              ),
              Gap(2.h),
              Row(
                children: [
                  Expanded(
                    child: AppTextWidget(
                      text: "Price at nearest stores",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  AppTextWidget(
                    text: "Update 2h ago",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.secondary,
                  ),
                ],
              ),
              Gap(2.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return NearShopsCard();
                },
              ),
              Gap(2.h),
              AppButtonWidget(
                onPressed: () {
                  Get.back();
                },
                text: "Scan Another Product",
                fontSize: 20,
                buttonColor: Colors.red.shade100,
                textColor: Colors.red,
                width: 100.w,
                fontWeight: FontWeight.w600,
                height: 7.h,
              ),
              Gap(2.h),
              AppButtonWidget(
                onPressed: () {
                  // Get.toNamed(Routes.SELECT_PREFERENCES);
                },
                text: "Unlock Store Addresses",
                fontSize: 20,
                width: 100.w,
                fontWeight: FontWeight.w600,
                height: 7.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoRow(Widget left, Widget right) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(child: left),
          Gap(3.w),
          Expanded(child: right),
        ],
      ),
    );
  }
}
