import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuca/app/routes/app_pages.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value < 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
