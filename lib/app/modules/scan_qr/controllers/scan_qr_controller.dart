import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nuca/services/shared_preferences_service.dart';
import '/app/modules/home/controllers/home_controller.dart';
import '/app/modules/scan_qr/views/components/manual_qr_code_bottom_sheet.dart';
import '/app/routes/app_pages.dart';
import '/core/network/repositories/user_repo.dart';
import '/utils/app_utils.dart';
import '/utils/ascyn_handler.dart';
import '/utils/async_state_handler.dart';

class ScanQrController extends GetxController {
  final UserRepo _userRepo = UserRepo();
  final scannerController = MobileScannerController();

  final TextEditingController manualCodeController = TextEditingController();
  var isFlashOn = false.obs;

  final Rx<Resource<void>> createScanResource = Resource.idle().obs;
  final homeController = Get.put(HomeController());
  @override
  void onInit() {
    super.onInit();
  }

  Future<String> _getDeviceUniqueId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? "";
    }
    return "";
  }

  Future<void> scanProduct(BuildContext context, String barcode) async {
    createScanResource.value = Resource.loading();
    final currency = await CurrencyPreferences.getCurrency();
    final country = await CurrencyPreferences.getCountry();

    final deviceId = await _getDeviceUniqueId();
    final result = await AsyncHandler.handleResourceCall<void>(
      context: Get.context,
      asyncCall: () => _userRepo.createScan(
        barcode: barcode,
        currency: currency ?? "",
        deviceId: SharedPreferencesService.getToken() == null ? deviceId : "",
        country: country ?? "",
      ),
      onSuccess: (_) async {
        await homeController.getScans();
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
        final code = manualCodeController.text.trim();
        scannerController.stop();
        scanProduct(Get.context!, code).then((_) {
          scannerController.start();
        });
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
