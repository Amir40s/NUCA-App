import 'package:ai_photo_generator/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  static bool isNullOrEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  static String capitalize(String value) {
    if (isNullOrEmpty(value)) return '';
    final v = value.trim();
    return v[0].toUpperCase() + v.substring(1);
  }

  static void showSnack({required String title, required String message}) {
    Get.snackbar(title, message);
  }

  static void showErrorSnack({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
    );
  }

  static Color fromHex(String hex) {
    var formatted = hex.replaceAll('#', '');
    if (formatted.length == 6) {
      formatted = 'FF$formatted';
    }
    return Color(int.parse(formatted, radix: 16));
  }

  Color withOpacity({required Color color, required double opacity}) {
    return color.withAlpha((opacity * 255).toInt());
  }

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not open URL: $url';
    }
}
}
