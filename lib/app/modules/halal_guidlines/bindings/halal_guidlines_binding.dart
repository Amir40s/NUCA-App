import 'package:get/get.dart';

import '../controllers/halal_guidlines_controller.dart';

class HalalGuidlinesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HalalGuidlinesController>(
      () => HalalGuidlinesController(),
    );
  }
}
