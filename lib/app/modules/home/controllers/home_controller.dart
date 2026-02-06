import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:nuca/core/network/repositories/user_repo.dart';
import 'package:nuca/domain/model/scan_history_model.dart';
import 'package:nuca/gen/assets.gen.dart';
import 'package:nuca/services/shared_preferences_service.dart';
import 'package:nuca/utils/ascyn_handler.dart';
import 'package:nuca/utils/async_state_handler.dart';

class HomeController extends GetxController {
  final UserRepo _userRepo = UserRepo();
  final foods = [
    {
      'image': Assets.images.food1.path,
      'title': 'Organic Orange Juice',
      'time': '2 hours ago',
      'price': '2.50',
      'isHalal': true,
    },
    {
      'image': Assets.images.food2.path,
      'title': 'Cheetos',
      'time': '4 hours ago',
      'price': '1.50',
      'isHalal': false,
    },
  ];

  final Rx<Resource<void>> getScansResource = Resource.idle().obs;
  var scanHistory = <ScanHistoryDataModel>[].obs;
  RxBool showBottomSheet = false.obs;
  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments['showBottomSheet'] != null) {
      showBottomSheet.value = Get.arguments['showBottomSheet'];
    }
    getScans();
    super.onInit();
  }

  Future<String> _getDeviceUniqueId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? "";
    }
    return "";
  }

  Future<void> getScans() async {
    getScansResource.value = Resource.loading();

    final deviceId = await _getDeviceUniqueId();

    final result = await AsyncHandler.handleResourceCall<ScanHistoryModel>(
      showLoading: false,
      context: Get.context,
      asyncCall: () => _userRepo.getScans(
        deviceId: SharedPreferencesService.getToken() == null ? deviceId : "",
      ),
    );

    getScansResource.value = result;

    if (result.isSuccess && result.data != null) {
      scanHistory.value = result.data!.data;
    }
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
