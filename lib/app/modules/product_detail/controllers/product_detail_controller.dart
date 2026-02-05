import 'dart:developer';
import 'package:get/get.dart';
import 'package:nuca/core/network/repositories/user_repo.dart';
import 'package:nuca/domain/model/scan_detail_model.dart';
import 'package:nuca/utils/ascyn_handler.dart';
import 'package:nuca/utils/async_state_handler.dart';

class ProductDetailController extends GetxController {
  final UserRepo _userRepo = UserRepo();
  String barcode = '';
  final getScanDetailsResource = Resource<ProductResponseModel>.idle().obs;
  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    if (args is Map && args['code'] != null) {
      barcode = args['code'].toString();
      log('Received barcode: $barcode');
      getScanDetails();
    } else {
      log('❌ Barcode missing in arguments');
      getScanDetailsResource.value = Resource.error(
        message: 'Invalid or missing barcode',
      );
    }
  }

  Future<void> getScanDetails() async {
    getScanDetailsResource.value = Resource.loading();
    final result = await AsyncHandler.handleResourceCall<ProductResponseModel>(
      showLoading: false,
      context: Get.context,
      asyncCall: () => _userRepo.getScanDetails(barcode: barcode),
    );

    getScanDetailsResource.value = result;
  }

  // if (result.isSuccess && result.data != null) {
  //   scanHistory.value = result.data!.data;
  // }
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
