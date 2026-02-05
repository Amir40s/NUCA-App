import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nuca/utils/export.dart';
import 'package:nuca/widgets/shimmer_widget.dart';
import 'package:sizer/sizer.dart';

class ShimmerScannedFoodCard extends StatelessWidget {
  const ShimmerScannedFoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: buildShimmer(
              context,
              height: 16.w,
              width: 16.w,
              borderRadius: 14,
            ),
          ),
          Gap(4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildShimmer(
                  context,
                  height: 2.h,
                  width: 50.w,
                  borderRadius: 4,
                ),
                Gap(1.h),
                buildShimmer(
                  context,
                  height: 1.8.h,
                  width: 35.w,
                  borderRadius: 4,
                ),
              ],
            ),
          ),
          Gap(3.w),
          buildShimmer(context, height: 3.h, width: 14.w, borderRadius: 30),
        ],
      ),
    );
  }
}
