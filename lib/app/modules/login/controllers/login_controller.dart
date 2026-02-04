import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/core/network/repositories/auth_repository.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/utils/ascyn_handler.dart';
import 'package:nuca/utils/async_state_handler.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final Rx<Resource<void>> loginResource = Resource.idle().obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login(BuildContext context) async {
    loginResource.value = Resource.loading();

    final result = await AsyncHandler.handleResourceCall<void>(
      context: Get.context,
      asyncCall: () => _authRepository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
      onSuccess: (_) {
        AppUtils.showMessage("Login  successfully", context: context);
        Get.offAllNamed(Routes.TABS);
      },
      onError: (msg) {
        AppUtils.showMessage(msg, context: context, isError: true);
      },
    );

    loginResource.value = result;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}
