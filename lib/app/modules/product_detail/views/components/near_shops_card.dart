import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';

class NearShopsCard extends StatelessWidget {
  const NearShopsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 1.h),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.primary,
            border: Border.all(color: AppColors.midGrey),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(Assets.images.food1.path, height: 6.h),
                  Gap(4.w),
                  Expanded(
                    child: AppTextWidget(
                      text: "Supermart",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  AppTextWidget(
                    text: "€2.50",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.secondary,
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.icons.person,
                    colorFilter: ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  Gap(1.h),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextWidget(
                          text: "85 Ave des champs-Elyses 75008 ",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Gap(1.h),
                        AppTextWidget(
                          text: "3.5 Km away",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          color: AppColors.secondary,
                        ),
                      ],
                    ),
                  ),
                  Gap(2.w),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.near_me, size: 3.h),
                        AppTextWidget(
                          text: 'Navigate',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Stack(
            children: [
              SvgPicture.asset(Assets.icons.curve),
              Positioned.fill(
                child: Center(
                  child: AppTextWidget(
                    text: "25% off",
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
