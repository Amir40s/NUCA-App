import 'package:flutter/material.dart';
import '../../../utils/export.dart';
import 'dashboard_nav_item.dart';

class DashboardNavbar extends StatelessWidget {
  const DashboardNavbar({super.key});

  @override
  Widget build(BuildContext context) {
     return Container(
      height: 7.h,
      width: double.infinity,
      // padding: EdgeInsets.symmetric(horizontal: 3.w),
      margin: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DashboardNavItem(icon: AppIcons.home, title: 'Home', index: 0),
              DashboardNavItem(
                icon: AppIcons.history,
                title: 'History',
                index: 1,
              ),

              DashboardNavItem(
                icon: AppIcons.setting,
                title: 'Setting',
                index: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
