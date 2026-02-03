// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:nuca/app/widgets/custom_snackbar.dart';

class AppUtils {
  static bool _isSnackbarActive = false;
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

  static Color withOpacity({required Color color, required double opacity}) {
    return color.withOpacity(opacity);
  }

  static void showMessage(
    String text, {
    bool isError = false,
    required BuildContext context,
  }) {
    if (!context.mounted || _isSnackbarActive) return;

    _isSnackbarActive = true;

    IconSnackBar.show(
      context,
      duration: Duration(milliseconds: 1500),
      snackBarType: isError ? SnackBarType.fail : SnackBarType.success,
      label: text,
      maxLines: 2,
    );

    Future.delayed(Duration(milliseconds: 1300), () {
      _isSnackbarActive = false;
    });
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
