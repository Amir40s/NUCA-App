import 'package:get/get.dart';
import '../history/history_controller.dart';
import '../home/home_controller.dart';
import '../settings/settings_controller.dart';
import 'export.dart';

class BottomNavBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
