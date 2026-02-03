import 'package:get/get.dart';

import '../controllers/subscription_managment_controller.dart';

class SubscriptionManagmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionManagmentController>(
      () => SubscriptionManagmentController(),
    );
  }
}
