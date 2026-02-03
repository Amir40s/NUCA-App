import 'package:get/get.dart';

class SubscriptionManagmentController extends GetxController {
  final email = 'info@gmail.com'.obs;
  final status = 'Active'.obs;
  final activeTill = '10/2/2025'.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void cancelSubscription() {
    Get.snackbar(
      'Subscription',
      'Your subscription has been cancelled',
      snackPosition: SnackPosition.BOTTOM,
    );
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
