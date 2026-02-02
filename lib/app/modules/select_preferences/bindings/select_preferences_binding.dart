import 'package:get/get.dart';

import '../controllers/select_preferences_controller.dart';

class SelectPreferencesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectPreferencesController>(
      () => SelectPreferencesController(),
    );
  }
}
