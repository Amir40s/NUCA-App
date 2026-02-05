import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuca/services/shared_preferences_service.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/utils/app_colors.dart';
import 'package:nuca/widgets/app_text_widget.dart';

class LogoutDialog {
  static void show() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: const AppTextWidget(text: "Logout"),
        content: const AppTextWidget(text: "Are you sure you want to log out?"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const AppTextWidget(
              text: "Cancel",
              color: AppColors.midGrey,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await SharedPreferencesService.clear();
              Get.offAllNamed(Routes.LOGIN);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const AppTextWidget(text: "Logout"),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
