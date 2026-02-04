import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:nuca/widgets/app_text_widget.dart';
import 'package:sizer/sizer.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String? image;
  final String title;
  final String? trailingText;
  final VoidCallback? onTap;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    this.onTap,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F1DD),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            image == null
                ? Icon(icon, size: 2.2.h)
                : SvgPicture.asset(
                    image ?? "",
                    height: 2.h,
                    colorFilter: ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
            Gap(4.w),
            Expanded(
              child: AppTextWidget(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (trailingText != null) ...[
              AppTextWidget(
                text: trailingText!,
                fontSize: 15,
                color: Colors.black,
              ),
              Gap(2.w),
            ],
            Icon(Icons.chevron_right, size: 2.4.h, color: Colors.black45),
          ],
        ),
      ),
    );
  }
}
