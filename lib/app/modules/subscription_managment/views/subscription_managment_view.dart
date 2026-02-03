import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:nuca/app/utils/app_utils.dart';
import 'package:nuca/app/widgets/app_text_widget.dart';
import 'package:nuca/app/widgets/custom_appbar.dart';
import 'package:nuca/app/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../controllers/subscription_managment_controller.dart';

class SubscriptionManagmentView
    extends GetView<SubscriptionManagmentController> {
  const SubscriptionManagmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Subscription"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppUtils.HorizontalPadding,
        ),
        child: Column(
          children: [
            Obx(
              () => SubscriptionInfoTile(
                title: 'Email:',
                value: controller.email.value,
              ),
            ),
            const SizedBox(height: 14),
            Obx(
              () => SubscriptionInfoTile(
                title: 'Subscription:',
                value: controller.status.value,
                valueColor: Colors.green,
              ),
            ),
            const SizedBox(height: 14),
            Obx(
              () => SubscriptionInfoTile(
                title: 'Active Till:',
                value: controller.activeTill.value,
              ),
            ),
            Gap(3.h),
            AppButtonWidget(
              onPressed: () {},
              text: 'Cancel Subscription',
              fontSize: 20,
              width: 100.w,
              fontWeight: FontWeight.w600,
              height: 7.h,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const SubscriptionInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          AppTextWidget(text: title, fontWeight: FontWeight.w600, fontSize: 16),
          const Spacer(),
          AppTextWidget(
            text: value,
            fontSize: 16,
            color: valueColor ?? AppColors.midGrey,
          ),
        ],
      ),
    );
  }
}
