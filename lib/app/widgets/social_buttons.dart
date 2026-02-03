import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nuca/app/utils/app_colors.dart';
import 'package:sizer/sizer.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String asset;
  const SocialButton({super.key, required this.onTap, required this.asset});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 6.h,
        width: 6.h,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SvgPicture.asset(asset, fit: BoxFit.contain),
      ),
    );
  }
}
