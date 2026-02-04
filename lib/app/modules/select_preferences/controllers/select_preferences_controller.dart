import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

class SelectPreferencesController extends GetxController {
  final RxString selectedCountry = ''.obs;
  final RxString selectedCurrency = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<String> getDeviceUniqueId() async {
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCountry(String country) {
    selectedCountry.value = country;
  }

  void setCurrency(String currency) {
    selectedCurrency.value = currency;
  }
}
