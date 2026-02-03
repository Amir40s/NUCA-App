import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            padding: EdgeInsets.all(1.2.h),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
