import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuca/core/network/repositories/user_repo.dart';
import 'package:nuca/services/shared_preferences_service.dart';
import 'package:nuca/utils/app_utils.dart';
import 'package:nuca/utils/ascyn_handler.dart';
import 'package:nuca/utils/async_state_handler.dart';

class EditProfileController extends GetxController {
  final UserRepo _userRepo = UserRepo();
  final ImagePicker _picker = ImagePicker();
  Rx<File?> profileImage = Rx<File?>(null);

  final nameController = TextEditingController(
    text: SharedPreferencesService.name,
  );
  final emailController = TextEditingController(
    text: SharedPreferencesService.email,
  );
  final passwordController = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final Rx<Resource<void>> profileUpdateResource = Resource.idle().obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> updateProfile(BuildContext context) async {
    profileUpdateResource.value = Resource.loading();

    final result = await AsyncHandler.handleResourceCall<void>(
      context: Get.context,
      asyncCall: () => _userRepo.updateProfile(
        name: nameController.text.trim(),
        profileImagePath: profileImage.value?.path ?? "",
      ),
      onSuccess: (_) {
        AppUtils.showMessage("Profile Updated successfully", context: context);
        Get.back();
      },
      onError: (msg) {
        log(msg);
        AppUtils.showMessage(msg, context: context, isError: true);
      },
    );

    profileUpdateResource.value = result;
  }

  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}
