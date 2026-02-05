import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nuca/app/modules/home/views/components/scanned_food_shimmer_card.dart';
import 'package:nuca/widgets/empty_widget.dart';
import 'package:nuca/widgets/error_widget.dart';
import '/app/modules/home/views/components/scanned_food_card.dart';
import '/app/routes/app_pages.dart';
import '/utils/export.dart';
import '/widgets/app_text_widget.dart';
import '/widgets/custom_appbar.dart';
import 'package:sizer/sizer.dart';

import '../controllers/scan_history_controller.dart';

class ScanHistoryView extends GetView<ScanHistoryController> {
  const ScanHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(title: "Scan History"),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppUtils.HorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(2.h),
                AppTextWidget(
                  text: "Your Scan History",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                Gap(1.h),
                AppTextWidget(
                  text:
                      "Track your scanned products here. Tap on a product to see details.",
                  fontSize: 14,
                ),
                Gap(2.h),
                TextFormField(
                  controller: controller.searchController,
                  onChanged: controller.onSearchChanged,
                  textInputAction: TextInputAction.search,
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
                AppTextWidget(
                  text: "Scan History",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Gap(1.5.h),
                Obx(() {
                  final state = controller.getScansResource.value;

                  Widget buildRefreshable(Widget child) {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: controller.getScans,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [child],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }

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
                    return buildRefreshable(
                      ErrorRetryWidget(
                        message: state.errorMessage ?? "Something went wrong",
                        onRetry: controller.getScans,
                      ),
                    );
                  } else if (state.isSuccess) {
                    if (controller.scanHistory.isEmpty) {
                      return buildRefreshable(
                        const EmptyWidget(message: "No scans found yet!"),
                      );
                    }
                    if (controller.filteredScanHistory.isEmpty) {
                      return buildRefreshable(
                        const EmptyWidget(
                          message: "No results found for your search",
                        ),
                      );
                    }
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: controller.getScans,
                        child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: controller.filteredScanHistory.length,
                          itemBuilder: (context, index) {
                            final food = controller.filteredScanHistory[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 1.h),
                              child: GestureDetector(
                                onTap: () => Get.toNamed(
                                  Routes.PRODUCT_DETAIL,
                                  arguments: {"code": food.barcode},
                                ),
                                child: ScannedFoodCard(
                                  image: food.image ?? '',
                                  title: food.name,
                                  time: food.scannedAt.toString(),
                                  price: food.brand,
                                  isHalal: food.overallStatus.toString(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
