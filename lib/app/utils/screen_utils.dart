import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Screen size helper. For responsive dimensions use the sizer package (.w, .h, .sp).
class ScreenSize {
  static Size _size = const Size(0, 0);

  static Size get size {
    final context = Get.context;
    if (context != null) {
      _size = MediaQuery.of(context).size;
    }
    return _size;
  }

  static double get width => size.width;
  static double get height => size.height;
}

