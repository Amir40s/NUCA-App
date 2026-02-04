import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/core/network/repositories/auth_repository.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/utils/ascyn_handler.dart';
import 'package:nuca/utils/async_state_handler.dart';

class SignUpController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final Rx<Resource<void>> signUpResource = Resource.idle().obs;
  @override
  void onInit() {
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

  Future<void> signUp(BuildContext context) async {
    signUpResource.value = Resource.loading();
    final deviceId = await _getDeviceUniqueId();

    final result = await AsyncHandler.handleResourceCall<void>(
      context: Get.context,
      asyncCall: () => _authRepository.signUp(
        deviceId: deviceId,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
      onSuccess: (_) {
        AppUtils.showMessage("User Created Successfully", context: context);
        Get.offAllNamed(Routes.TABS);
      },
      onError: (msg) {
        AppUtils.showMessage(msg, context: context, isError: true);
      },
    );

    signUpResource.value = result;
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
