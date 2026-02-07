import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:nuca/domain/model/scan_detail_model.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class NearShopsCard extends StatelessWidget {
  const NearShopsCard({super.key, required this.model});
  final ShopModel? model;
  @override
  Widget build(BuildContext context) {
    Future<void> openLink(String? addressOrUrl) async {
      if (addressOrUrl == null || addressOrUrl.isEmpty) return;

      Uri uri;
      if (addressOrUrl.startsWith('http')) {
        uri = Uri.parse(addressOrUrl);
      } else {
        final encodedAddress = Uri.encodeComponent(addressOrUrl);
        uri = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$encodedAddress',
        );
      }

      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        log('Error launching URL for $addressOrUrl: $e');
      }
    }

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
              Gap(0.5.h),
              Row(
                children: [
                  Image.asset(Assets.images.food1.path, height: 6.h),
                  // ClipRRect(
                  //           borderRadius: BorderRadius.circular(12),
                  //           child: Image.network(
                  //             model..isNotEmpty
                  //                 ? model.image
                  //                 : Assets.images.food1.path,
                  //             width: 28.w,
                  //             height: 28.w,
                  //             fit: BoxFit.cover,
                  //             errorBuilder: (context, error, stackTrace) {
                  //               return Container(
                  //                 width: 28.w,
                  //                 height: 28.w,
                  //                 color: Colors.grey.shade200,
                  //                 child: const Icon(Icons.broken_image, size: 24),
                  //               );
                  //             },
                  //           ),
                  //         ),
                  Gap(4.w),
                  Expanded(
                    child: AppTextWidget(
                      text: model?.merchant ?? "",
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  AppTextWidget(
                    text: model?.price ?? "",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.secondary,
                  ),
                ],
              ),
              Gap(0.5.h),
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
                    child: AppTextWidget(
                      text: model?.address ?? '',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Gap(2.w),
                  ElevatedButton(
                    onPressed: () => openLink(model?.link),
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
          top: 0,
          right: 0,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(12),
            ),
            color: AppColors.secondary,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 80),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AppTextWidget(
                    text: model?.size ?? "",
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
