import 'package:get/get.dart';
import 'package:nuca/app/modules/home/controllers/home_controller.dart';
import 'package:nuca/app/modules/profile/controllers/profile_controller.dart';
import 'package:nuca/app/modules/scan_qr/controllers/scan_qr_controller.dart';

import '../controllers/tabs_controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TabsController>(() => TabsController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ScanQrController>(() => ScanQrController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
