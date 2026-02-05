import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuca/core/network/repositories/user_repo.dart';
import 'package:nuca/domain/model/scan_history_model.dart';
import 'package:nuca/utils/ascyn_handler.dart';
import 'package:nuca/utils/async_state_handler.dart';

class ScanHistoryController extends GetxController {
  final UserRepo _userRepo = UserRepo();
  final Rx<Resource<void>> getScansResource = Resource.idle().obs;
  var scanHistory = <ScanHistoryDataModel>[].obs;
  var filteredScanHistory = <ScanHistoryDataModel>[].obs;

  TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    getScans();
    ever(scanHistory, (_) => filteredScanHistory.assignAll(scanHistory));
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
      asyncCall: () => _userRepo.getScans(deviceId: deviceId),
    );

    getScansResource.value = result;

    if (result.isSuccess && result.data != null) {
      scanHistory.value = result.data!.data;
      filteredScanHistory.assignAll(scanHistory);
    }
  }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      filteredScanHistory.assignAll(scanHistory);
    } else {
      final lowerQuery = query.toLowerCase();
      filteredScanHistory.assignAll(
        scanHistory.where(
          (item) =>
              item.name.toLowerCase().contains(lowerQuery) ||
              item.brand.toLowerCase().contains(lowerQuery) ||
              item.barcode.toString().contains(lowerQuery),
        ),
      );
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
