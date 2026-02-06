import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nuca/services/shared_preferences_service.dart';
import '/app/routes/app_pages.dart';
import '/core/network/repositories/auth_repository.dart';
import '/utils/app_utils.dart';
import '/utils/ascyn_handler.dart';
import '/utils/async_state_handler.dart';

class SelectPreferencesController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final Rx<Resource<void>> savePreferencesResource = Resource.idle().obs;
  final RxString selectedCountry =
      (SharedPreferencesService.selectedCountry ?? '').obs;
  final RxString selectedCurrency =
      (SharedPreferencesService.selectedCurrency ?? '').obs;
  late bool showBack;

  @override
  void onInit() {
    showBack = Get.arguments != null && Get.arguments['showBack'] != null
        ? Get.arguments['showBack']
        : false;
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
        deviceId: SharedPreferencesService.getToken() == null ? deviceId : "",
        country: selectedCountry.value,
        currency: selectedCurrency.value,
      ),
      onSuccess: (_) async {
        AppUtils.showMessage(
          "Preferences saved successfully",
          context: context,
        );
        await CurrencyPreferences.setCurrency(selectedCurrency.value);
        await CurrencyPreferences.setCountry(selectedCountry.value);
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
