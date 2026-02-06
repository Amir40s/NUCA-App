import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nuca/app/modules/product_detail/views/components/ingrident_card.dart';
import 'package:nuca/app/modules/product_detail/views/components/near_shops_card.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:nuca/widgets/custom_appbar.dart';
import 'package:nuca/widgets/custom_button.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:nuca/widgets/empty_widget.dart';
import 'package:nuca/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();

    return Scaffold(
      appBar: CustomAppBar(title: "Product Details", showShare: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppUtils.HorizontalPadding,
            vertical: AppUtils.VerticalPadding,
          ),
          child: Obx(() {
            final resource = controller.getScanDetailsResource.value;

            if (resource.isLoading) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildShimmer(
                    context,
                    height: 28.w,
                    width: 28.w,
                    borderRadius: 12,
                  ),
                  Gap(2.h),
                  buildShimmer(context, height: 18, width: Get.width * 0.6),
                  Gap(1.h),
                  buildShimmer(context, height: 14, width: Get.width * 0.4),
                  Gap(2.h),
                  Row(
                    children: [
                      Expanded(child: buildShimmer(context, height: 100)),
                      Gap(3.w),
                      Expanded(child: buildShimmer(context, height: 100)),
                    ],
                  ),
                  Gap(2.h),
                  Row(
                    children: [
                      Expanded(child: buildShimmer(context, height: 100)),
                      Gap(3.w),
                      Expanded(child: buildShimmer(context, height: 100)),
                    ],
                  ),
                  Gap(2.h),
                  buildShimmer(context, height: 60, width: Get.width),
                  Gap(2.h),
                  buildShimmer(context, height: 60, width: Get.width),
                ],
              );
            }
            if (resource.isError) {
              return Center(child: ErrorWidget("No Data Found"));
            }
            final model = resource.data?.data;
            if (model == null) {
              return const Center(
                child: EmptyWidget(message: "Product not found"),
              );
            }
            return Column(
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
                        child: Image.network(
                          model.image.isNotEmpty
                              ? model.image
                              : Assets.images.food1.path,
                          width: 24.w,
                          height: 24.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 28.w,
                              height: 28.w,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.broken_image, size: 24),
                            );
                          },
                        ),
                      ),
                      Gap(3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextWidget(
                              text: model.name,
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            Gap(1.h),
                            AppTextWidget(
                              text: 'Brand:${model.brand}',
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
                Gap(1.5.h),
                AppTextWidget(
                  text: 'Product Information',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                Gap(1.5.h),
                infoRow(
                  HalalStatusCard(status: model.halalStatus),
                  NutritionScoreCard(
                    status: model.halalStatus,
                    grade: model.nutritionScore,
                    iconPath: Assets.icons.nutrationScore,
                    name: 'Nutrition Score',
                    value: 'Grade ${model.nutritionScore}',
                  ),
                ),
                Gap(1.h),
                infoRow(
                  InfoCard(
                    status: model.halalStatus,
                    title: 'Energy',
                    value:
                        '${model.nutrition?.energy?.value} ${model.nutrition?.energy?.unit}',
                    iconPath: Assets.icons.energy,
                  ),
                  InfoCard(
                    status: model.halalStatus,
                    title: 'Sugar',
                    value:
                        '${model.nutrition?.sugar?.value}${model.nutrition?.sugar?.unit}',
                    iconPath: Assets.icons.sugar,
                  ),
                ),
                Gap(1.h),
                infoRow(
                  InfoCard(
                    status: model.halalStatus,
                    title: 'Salt',
                    value:
                        '${model.nutrition?.salt?.value}${model.nutrition?.salt?.unit}',
                    iconPath: Assets.icons.salt,
                  ),
                  InfoCard(
                    status: model.halalStatus,
                    title: 'Carbs',
                    value:
                        '${model.nutrition?.carbs?.value}${model.nutrition?.carbs?.unit}',
                    iconPath: Assets.icons.carbs,
                  ),
                ),
                Gap(1.h),
                infoRow(
                  InfoCard(
                    status: model.halalStatus,
                    title: 'GMO / OGM',
                    value: model.additives?.gmo.toString() ?? "",
                    iconPath: Assets.icons.gmo,
                  ),
                  InfoCard(
                    status: model.halalStatus,
                    title: 'Bio Status',
                    value: model.additives?.bio ?? "",
                    iconPath: Assets.icons.bio,
                  ),
                ),
                Gap(1.h),
                infoRow(
                  InfoCard(
                    status: model.halalStatus,
                    title: 'Proteins',
                    value:
                        '${model.nutrition?.protein?.value}${model.nutrition?.protein?.unit}',
                    iconPath: Assets.icons.protiens,
                  ),
                  NutritionScoreCard(
                    status: model.halalStatus,
                    name: 'Additives Status',
                    value: 'Nova ${model.additives?.nova}',
                    iconPath: Assets.icons.addictiveStatus,
                    grade: model.additives?.nova ?? "",
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
                    // AppTextWidget(
                    //   text: "Update 2h ago",
                    //   fontWeight: FontWeight.w600,
                    //   fontSize: 14,
                    //   color: AppColors.secondary,
                    // ),
                  ],
                ),
                Gap(2.h),
                model.shops.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: model.shops.length,
                        itemBuilder: (context, index) {
                          final shopModel = model.shops[index];
                          return NearShopsCard(model: shopModel);
                        },
                      )
                    : Center(
                        child: EmptyWidget(
                          message: "No Shops Found",
                          icon: Icons.store,
                        ),
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
                    Get.toNamed(Routes.SUBSCRIPTION);
                  },
                  text: "Unlock Store Addresses",
                  fontSize: 20,
                  width: 100.w,
                  fontWeight: FontWeight.w600,
                  height: 7.h,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget infoRow(Widget left, Widget right) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(child: left),
          Gap(2.5.w),
          Expanded(child: right),
        ],
      ),
    );
  }
}
