import 'package:get/get.dart';

class ChooseLanguageController extends GetxController {
  final RxString selectedLanguage = "English".obs;
  @override
  void onInit() {
    super.onInit();
  }

  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }

  bool isSelected(String language) {
    return selectedLanguage.value == language;
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
