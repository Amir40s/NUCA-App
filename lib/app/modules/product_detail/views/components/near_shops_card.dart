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
    Future<void> openMaps(String? addressOrUrl) async {
      if (addressOrUrl == null || addressOrUrl.isEmpty) return;
      Uri uri;
      if (addressOrUrl.startsWith('https://www.google.com/maps')) {
        uri = Uri.parse(addressOrUrl);
      } else {
        final encodedAddress = Uri.encodeComponent(addressOrUrl);
        uri = Uri.parse(
          "https://www.google.com/maps/search/?api=1&query=$encodedAddress",
        );
      }

      try {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        }
      } catch (e) {
        log('Error launching Maps for $addressOrUrl: $e');
      }
    }

    return Container(
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
          Gap(1.h),
          Row(
            children: [
              SvgPicture.asset(
                Assets.icons.person,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
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
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  onPressed: () {
                    openMaps(model?.googleMapsLink);
                  },
                  icon: Icon(Icons.near_me, size: 2.5.h, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
