import 'package:get/get.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/services/shared_preferences_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2));

    final hasSeenOnboarding = await OnboardingPreferences.hasSeenOnboarding();

    if (!hasSeenOnboarding) {
      Get.offAllNamed(Routes.CHOOSE_LANGUAGE, arguments: {"showBack": false});
      return;
    }

    final token = await SharedPreferencesService.getToken();
    final isExpired = await SharedPreferencesService.isTokenExpired;

    if (token != null && !isExpired) {
      Get.offAllNamed(Routes.TABS);
      return;
    }
    Get.offAllNamed(Routes.HOME, arguments: {"showBottomSheet": true});
  }
}
