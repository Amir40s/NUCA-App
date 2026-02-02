// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  static const HorizontalPadding = 20.0;
  static const VerticalPadding = 20.0;
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

  static Color fromHex(String hex) {
    var formatted = hex.replaceAll('#', '');
    if (formatted.length == 6) {
      formatted = 'FF$formatted';
    }
    return Color(int.parse(formatted, radix: 16));
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600;
  }

  static int gridCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 4; // large tablets
    if (width >= 600) return 3; // tablets
    return 2; // phones
  }

  static double iconSize(BuildContext context) {
    return isTablet(context) ? 45 : 24;
  }

  static double width(BuildContext context) {
    return isTablet(context) ? 28 : 24;
  }

  static double height(BuildContext context) {
    return isTablet(context) ? 28 : 24;
  }
}
