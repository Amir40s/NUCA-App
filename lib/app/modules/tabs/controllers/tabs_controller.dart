import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuca/app/modules/home/views/home_view.dart';
import 'package:nuca/app/modules/profile/views/profile_view.dart';
import 'package:nuca/app/modules/scan_qr/views/scan_qr_view.dart';

class TabsController extends GetxController {
  var currentIndex = 0.obs;

  final List<Widget> pages = [HomeView(), ScanQrView(), ProfileView()];

  @override
  void onInit() {
    super.onInit();
  }

  void changeTab(int index) {
    currentIndex.value = index;
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
