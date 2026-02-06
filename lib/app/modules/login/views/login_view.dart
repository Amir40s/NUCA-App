import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/app/routes/app_pages.dart';
import '/utils/app_colors.dart';
import '/utils/app_utils.dart';
import '/widgets/app_text_widget.dart';
import '/widgets/custom_button.dart';
import '/widgets/social_buttons.dart';
import '/gen/assets.gen.dart';
import 'package:sizer/sizer.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppUtils.HorizontalPadding,
              vertical: AppUtils.VerticalPadding,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(3.h),
                  Center(
                    child: Image.asset(Assets.icons.appIcon.path, height: 10.h),
                  ),
                  Gap(3.h),
                  AppTextWidget(
                    text: 'Log In',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                  Gap(1.h),
                  AppTextWidget(
                    text: 'Please enter your details',
                    fontSize: 17,
                    color: AppColors.midGrey,
                    fontWeight: FontWeight.w500,
                  ),
                  Gap(4.h),
                  AppTextWidget(
                    text: "Email",
                    fontWeight: FontWeight.w500,
                    fontSize: 17.sp,
                  ),
                  Gap(2.h),
                  TextFormField(
                    controller: controller.emailController,
                    focusNode: controller.emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Example@gmail.com',
                    ),
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
                    onFieldSubmitted: (_) {
                      FocusScope.of(
                        context,
                      ).requestFocus(controller.passwordFocus);
                    },
                  ),
                  Gap(2.h),
                  AppTextWidget(
                    text: "Password",
                    fontWeight: FontWeight.w500,
                    fontSize: 17.sp,
                  ),
                  Gap(2.h),
                  TextFormField(
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocus,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'At least 8 characters',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      if (value.length > 20) {
                        return 'Password must be less than 20 characters';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  Gap(4.h),
                  AppButtonWidget(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.login(context);
                      }
                    },
                    text: "Log In",
                    fontSize: 20,
                    width: 100.w,
                    fontWeight: FontWeight.w600,
                    height: 7.h,
                  ),
                  Gap(3.h),
                  Center(
                    child: AppTextWidget(
                      text: 'Or Log In with',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  Gap(4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (Platform.isAndroid)
                        SocialButton(
                          asset: Assets.icons.google,
                          onTap: () {
                            controller.signInWithGoogle(context);
                          },
                        ),
                      if (Platform.isIOS) Gap(6.w),
                      if (Platform.isIOS)
                        SocialButton(asset: Assets.icons.apple, onTap: () {}),
                    ],
                  ),
                  Gap(4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.offAllNamed(Routes.SIGN_UP);
                        },
                        child: const AppTextWidget(
                          text: "Don't have an account? ",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.offAllNamed(Routes.SIGN_UP);
                        },
                        child: const AppTextWidget(
                          text: "Sign Up",
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Gap(2.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
