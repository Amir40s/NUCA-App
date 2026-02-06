import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuca/app/modules/select_preferences/controllers/select_preferences_controller.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:nuca/core/network/repositories/auth_repository.dart';
import 'package:nuca/services/shared_preferences_service.dart';
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
  final Rx<Resource<void>> signUpWithGoogleResource = Resource.idle().obs;
  final selectPreferenceController = Get.put(SelectPreferencesController());
  @override
  void onInit() {
    if (kDebugMode) {
      emailController.text = "test01@gmail.com";
      nameController.text = "test01";
      passwordController.text = "12345678";
    }
    super.onInit();
  }

  Future<void> signUp(BuildContext context) async {
    signUpResource.value = Resource.loading();
    final currency = await CurrencyPreferences.getCurrency();
    final country = await CurrencyPreferences.getCountry();

    final result = await AsyncHandler.handleResourceCall<void>(
      context: Get.context,
      asyncCall: () => _authRepository.signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        currency: currency ?? "",
        country: country ?? "",
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

  Future<void> signUpWithGoogle(
    BuildContext context,
    String name,
    String email,
    String profileImage,
    bool isLogin,
  ) async {
    signUpWithGoogleResource.value = Resource.loading();
    final result = await AsyncHandler.handleResourceCall<void>(
      context: Get.context,
      asyncCall: () => _authRepository.loginWithGoogle(
        email: email,
        name: name,
        isLogin: isLogin,
        profileImage: profileImage,
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

    signUpWithGoogleResource.value = result;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId:
        '230947521329-j4lge01b71b788fpostuk0bahng802cl.apps.googleusercontent.com',
  );

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
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
      final String? profileImage = account.photoUrl;

      log('✅ Google User Logged In');
      log('👤 Name: $name');
      log('📧 Email: $email');

      await signUpWithGoogle(context, name, email, profileImage ?? "", false);
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
