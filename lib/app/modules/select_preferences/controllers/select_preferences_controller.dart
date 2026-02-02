import 'package:get/get.dart';

class SelectPreferencesController extends GetxController {
  final RxString selectedCountry = ''.obs;
  final RxString selectedCurrency = ''.obs;

  @override
  void onInit() {
    super.onInit();
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
