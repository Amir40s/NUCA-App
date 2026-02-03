import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nuca/app/modules/scan_qr/views/components/manual_qr_code_bottom_sheet.dart';
import 'package:nuca/app/routes/app_pages.dart';

class ScanQrController extends GetxController {
  final scannerController = MobileScannerController();

  final TextEditingController manualCodeController = TextEditingController();
  var isFlashOn = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void toggleTorch() {
    scannerController.toggleTorch();
    isFlashOn.value = !isFlashOn.value;
  }

  void switchCamera() {
    scannerController.switchCamera();
  }

  void onBarcodeDetected(String code) {
    scannerController.stop();
    log('QR/Barcode: $code');

    Get.toNamed(Routes.PRODUCT_DETAIL, arguments: {'code': code})?.then((
      value,
    ) {
      scannerController.start();
    });
  }

  void showManualEntry() {
    manualCodeController.clear();
    ManualQrCodeBottomSheet(
      manualCodeController: manualCodeController,
      onSubmit: () {
        scannerController.stop();
      },
    ).show();
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
