import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nuca/app/modules/home/views/components/scanned_food_card.dart';
import 'package:nuca/app/modules/home/views/components/scanned_food_shimmer_card.dart';
import 'package:nuca/app/modules/home/views/home_cards.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:nuca/widgets/custom_button.dart';
import 'package:nuca/widgets/empty_widget.dart';
import 'package:nuca/widgets/error_widget.dart';
import 'package:sizer/sizer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await controller.getScans();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                  text: 'Hello 👋',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                Gap(1.h),
                AppTextWidget(
                  text: 'Eat with Confidence',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.midGrey,
                ),
                Gap(2.h),
                TextFormField(
                  readOnly: true,
                  textInputAction: TextInputAction.search,
                  onTap: () {
                    Get.toNamed(Routes.SCAN_HISTORY);
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.lightGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.lightGrey),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search by product name, SKU, or model number',
                  ),
                ),
                Gap(2.5.h),
                if (controller.showBottomSheet.value == true)
                  AppButtonWidget(
                    onPressed: () {
                      Get.toNamed(Routes.SCAN_QR);
                    },
                    text: 'Scan Code',
                    fontSize: 20,
                    width: 100.w,
                    fontWeight: FontWeight.w600,
                    height: 7.h,
                  ),
                Gap(2.5.h),
                HomeCards(),
                Gap(3.h),
                Row(
                  children: [
                    Expanded(
                      child: AppTextWidget(
                        text: "Recent Scans",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    controller.showBottomSheet.value == false
                        ? TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.SCAN_HISTORY);
                            },
                            child: AppTextWidget(
                              text: "See all",
                              fontSize: 18,
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                Obx(() {
                  final state = controller.getScansResource.value;

                  if (state.isLoading) {
                    return Column(
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: const ShimmerScannedFoodCard(),
                        ),
                      ),
                    );
                  } else if (state.isError) {
                    return ErrorRetryWidget(
                      message: state.errorMessage ?? "Something went wrong",
                      onRetry: controller.getScans,
                    );
                  } else if (state.isSuccess) {
                    if (controller.scanHistory.isEmpty) {
                      return const EmptyWidget(message: "No scans found yet!");
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.scanHistory.length > 3
                          ? 3
                          : controller.scanHistory.length,
                      itemBuilder: (context, index) {
                        final food = controller.scanHistory[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: GestureDetector(
                            onTap: () => Get.toNamed(
                              Routes.PRODUCT_DETAIL,
                              arguments: {"code": "1223"},
                            ),
                            child: ScannedFoodCard(
                              image: food.image ?? '',
                              title: food.name,
                              time: food.scannedAt.toString(),
                              price: food.brand,
                              isHalal: food.overallStatus,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }),
                Gap(10.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: controller.showBottomSheet.value == true
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: AppTextWidget(
                        text: 'New here ? Join our community today.',
                        fontWeight: FontWeight.w500,
                        color: AppColors.midGrey,
                      ),
                    ),
                    Gap(1.5.h),
                    AppButtonWidget(
                      onPressed: () {
                        Get.offAllNamed(Routes.SIGN_UP);
                      },
                      text: "Create Account",
                      fontSize: 20,
                      width: 100.w,
                      fontWeight: FontWeight.w600,
                      height: 7.h,
                    ),
                    Gap(1.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          child: const AppTextWidget(
                            text: "Already have an account? ",
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
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          child: const AppTextWidget(
                            text: "Sign In",
                            color: AppColors.secondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
