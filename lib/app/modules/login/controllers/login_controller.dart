import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final Rx<Resource<void>> loginWithGoogleResource = Resource.idle().obs;
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
        log(msg);
        AppUtils.showMessage(msg, context: context, isError: true);
      },
    );

    loginResource.value = result;
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

  Future<void> loginWithGoogle(
    BuildContext context,
    String name,
    String email,
    bool isLogin,
  ) async {
    loginWithGoogleResource.value = Resource.loading();
    final deviceId = await _getDeviceUniqueId();
    final result = await AsyncHandler.handleResourceCall<void>(
      context: Get.context,
      asyncCall: () => _authRepository.loginWithGoogle(
        email: email,
        name: name,
        deviceId: deviceId,
        isLogin: isLogin,
      ),
      onSuccess: (_) {
        AppUtils.showMessage(
          "Login With Google Successfully",
          context: context,
        );
        Get.offAllNamed(Routes.TABS);
      },
      onError: (msg) {
        AppUtils.showMessage(msg, context: context, isError: true);
      },
    );

    loginWithGoogleResource.value = result;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId:
        '230947521329-81v6m2ea9rld4474fguadke1rrjho3g1.apps.googleusercontent.com',
  );

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        log('User cancelled Google Sign-In');
        return;
      }

      final GoogleSignInAuthentication auth = await account.authentication;

      final String? idToken = auth.idToken;

      if (idToken == null) {
        log('idToken is null — check WEB client ID');
        return;
      }

      final String name = account.displayName ?? '';
      final String email = account.email;

      log('✅ Google User Logged In');
      log('👤 Name: $name');
      log('📧 Email: $email');

      /// 🚀 CALL BACKEND API HERE
      await loginWithGoogle(
        context,
        name,
        email,
        true, // isLogin (false if signup)
      );
    } catch (e, stack) {
      log('❌ Google Sign-In error');
      log(e.toString());
      log(stack.toString());
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
