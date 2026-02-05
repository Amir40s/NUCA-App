import 'dart:developer';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  late String barcode;
  @override
  void onInit() {
    barcode = Get.arguments['code'] ?? '';
    log('Received barcode: $barcode');
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
}
