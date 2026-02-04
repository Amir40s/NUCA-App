import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '/app/routes/app_pages.dart';
import '/core/network/repositories/auth_repository.dart';
import '/utils/app_utils.dart';
import '/utils/ascyn_handler.dart';
import '/utils/async_state_handler.dart';

class SelectPreferencesController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final Rx<Resource<void>> savePreferencesResource = Resource.idle().obs;
  final RxString selectedCountry = ''.obs;
  final RxString selectedCurrency = ''.obs;

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

  Future<void> savePreferences(BuildContext context) async {
    savePreferencesResource.value = Resource.loading();

    final deviceId = await _getDeviceUniqueId();

    final result = await AsyncHandler.handleResourceCall<void>(
      context: Get.context,
      asyncCall: () => _authRepository.selectPreference(
        deviceId: deviceId,
        country: selectedCountry.value,
        currency: selectedCurrency.value,
      ),
      onSuccess: (_) {
        AppUtils.showMessage(
          "Preferences saved successfully",
          context: context,
        );
        Get.offAllNamed(Routes.ON_BOARDING);
      },
      onError: (msg) {
        AppUtils.showMessage(msg, context: context, isError: true);
      },
    );

    savePreferencesResource.value = result;
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
