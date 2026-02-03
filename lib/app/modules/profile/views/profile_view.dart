import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:nuca/app/modules/profile/views/components/profile_tile.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:nuca/app/widgets/app_text_widget.dart';
import 'package:nuca/app/widgets/custom_button.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 4.h,
                    backgroundImage: const NetworkImage(
                      'https://i.pravatar.cc/300',
                    ),
                  ),
                  Gap(4.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: 'Daniel Jones',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      Gap(0.6.h),
                      AppTextWidget(
                        text: 'daniel.jones@example.com',
                        fontSize: 14,
                        color: AppColors.midGrey,
                      ),
                      Gap(0.8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 0.6.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.lightGrey),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.orange,
                            ),
                            Gap(1.w),
                            AppTextWidget(
                              text: 'Premium',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Gap(4.h),
              AppTextWidget(
                text: 'Account',
                fontSize: 16,
                color: AppColors.midGrey,
                fontWeight: FontWeight.w900,
              ),
              Gap(1.5.h),
              ProfileTile(
                icon: LucideIcons.user,
                title: 'My Account',
                onTap: () => Get.toNamed(Routes.EDIT_PROFILE),
              ),
              Gap(1.2.h),
              ProfileTile(
                icon: Icons.star_border,
                image: Assets.icons.subscriptionStatus,
                title: 'Subscription Status',
              ),
              Gap(3.h),
              AppTextWidget(
                text: 'Bottom Section',
                fontSize: 16,
                color: AppColors.midGrey,
                fontWeight: FontWeight.w900,
              ),
              Gap(1.5.h),
              ProfileTile(
                icon: Icons.language,
                title: 'Language',
                onTap: () => Get.toNamed(Routes.CHOOSE_LANGUAGE),
                trailingText: 'English',
              ),
              Gap(1.2.h),
              ProfileTile(
                icon: Icons.attach_money,
                image: Assets.icons.coin,
                title: 'Currency',
                trailingText: '\$',
                onTap: () => Get.toNamed(Routes.SELECT_PREFERENCES),
              ),
              Gap(3.h),
              AppTextWidget(
                text: 'App Info',
                fontSize: 16,
                color: AppColors.midGrey,
                fontWeight: FontWeight.w900,
              ),
              Gap(1.5.h),
              ProfileTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                image: Assets.icons.privcyPolicy,
              ),
              Gap(1.2.h),
              ProfileTile(
                icon: Icons.verified_user_outlined,
                title: 'Halal Guidelines',
                image: Assets.icons.halalIcon,
              ),
              Gap(3.h),
              AppButtonWidget(
                onPressed: () {},
                text: "Log Out",
                suffixIcon: Icon(Icons.login, color: Colors.white),
                fontSize: 20,
                textColor: Colors.white,
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
