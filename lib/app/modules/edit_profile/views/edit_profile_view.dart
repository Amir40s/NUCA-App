import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '/services/shared_preferences_service.dart';
import '/utils/export.dart';
import '/widgets/custom_appbar.dart';
import '/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final controller = Get.put(EditProfileController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppUtils.HorizontalPadding,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gap(2.h),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Obx(() {
                    final image = controller.profileImage.value;
                    return CircleAvatar(
                      radius: 8.h,
                      backgroundColor: AppColors.primary,
                      backgroundImage: image != null
                          ? FileImage(image)
                          : NetworkImage(
                              SharedPreferencesService.profileImage ?? "",
                            ),
                      child:
                          image == null &&
                              SharedPreferencesService.profileImage == null
                          ? Icon(
                              LucideIcons.user,
                              size: 4.h,
                              color: Colors.grey.shade700,
                            )
                          : null,
                    );
                  }),
                  Positioned(
                    bottom: -0.4.h,
                    right: -0.4.h,
                    child: GestureDetector(
                      onTap: controller.pickProfileImage,
                      child: Container(
                        height: 5.h,
                        width: 5.h,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: SvgPicture.asset(Assets.icons.camera),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              TextFormField(
                controller: controller.nameController,
                focusNode: controller.nameFocus,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  if (value.trim().length < 3) {
                    return 'Name must be at least 3 characters';
                  }
                  if (value.trim().length > 30) {
                    return 'Name must be less than 30 characters';
                  }
                  return null;
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(controller.emailFocus),
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.emailController,
                focusNode: controller.emailFocus,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                enabled: false,
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Enter a valid email address';
                  }
                  if (value.length > 50) {
                    return 'Email must be less than 50 characters';
                  }
                  return null;
                },
              ),

              // const SizedBox(height: 20),
              // TextFormField(
              //   controller: controller.passwordController,
              //   focusNode: controller.passwordFocus,
              //   obscureText: true,
              //   textInputAction: TextInputAction.done,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Password is required';
              //     }
              //     if (value.length < 8) {
              //       return 'Password must be at least 8 characters';
              //     }
              //     if (value.length > 20) {
              //       return 'Password must be less than 20 characters';
              //     }
              //     return null;
              //   },
              //   decoration: const InputDecoration(hintText: 'Password'),
              // ),
              const SizedBox(height: 30),
              AppButtonWidget(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.updateProfile(context);
                  }
                },
                text: "Update",
                fontSize: 20,
                width: 100.w,
                fontWeight: FontWeight.w600,
                height: 7.h,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
