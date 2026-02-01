import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
 import '../../../utils/export.dart';
import '../../../widgets/app_text.dart';
 import '../bottom_nav_controller.dart';

class DashboardNavItem extends StatelessWidget {
  const DashboardNavItem({
    super.key,
    required this.icon,
    required this.title,
    required this.index,
  });

  final String icon, title;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dashboardC = Get.find<BottomNavController>();

    return GestureDetector(
      onTap: () => dashboardC.index.value = index,
      child: Obx(() {
        final isSelected = dashboardC.index.value == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 12 : 0,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color:
            isSelected
                ? AppUtils().withOpacity(
              color: theme.primaryColor,
              opacity: .24,
            )
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                icon,
                color:
                isSelected
                    ? theme.primaryColor
                    : Colors.grey,
                height: 2.8.h,
                width: 5.2.w,
              ),

              // Smooth text reveal (no layout jump)
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                child:
                isSelected
                    ? Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: AppText(
                    title,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryColor,
                  ),
                )
                    : const SizedBox(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
