import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nuca/app/modules/scan_qr/views/components/manual_qr_code_bottom_sheet.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/core/network/repositories/user_repo.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/utils/ascyn_handler.dart';
import 'package:nuca/utils/async_state_handler.dart';

class ScanQrController extends GetxController {
  final UserRepo _userRepo = UserRepo();
  final scannerController = MobileScannerController();

  final TextEditingController manualCodeController = TextEditingController();
  var isFlashOn = false.obs;

  final Rx<Resource<void>> createScanResource = Resource.idle().obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> scanProduct(BuildContext context, String barcode) async {
    createScanResource.value = Resource.loading();

    final result = await AsyncHandler.handleResourceCall<void>(
      context: Get.context,
      asyncCall: () => _userRepo.createScan(barcode: barcode),
      onSuccess: (_) {
        AppUtils.showMessage("Product Scan Successfully", context: context);
        Get.toNamed(Routes.PRODUCT_DETAIL, arguments: {'code': barcode});
      },
      onError: (msg) {
        AppUtils.showMessage(msg, context: context, isError: true);
      },
    );

    createScanResource.value = result;
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
    log('QR/Barcode detected: $code');

    scanProduct(Get.context!, code).then((_) {
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
