// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sizer/sizer.dart';
// import '../core/export.dart';
// import '../utils/export.dart';
// import '../widgets/export.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String? title;
//   final String? userName;
//   final String? lastSyncText;
//   final VoidCallback? onSyncTap;
//   final VoidCallback? onNotificationTap;
//   final VoidCallback? onLogoutTap;
//   final double height;
//   final bool isBackBtn;
//   final bool isVisibleActions;
//
//   const CustomAppBar({
//     super.key,
//     this.title,
//     this.userName,
//     this.lastSyncText,
//     this.onSyncTap,
//     this.onNotificationTap,
//     this.onLogoutTap,
//     this.height = 20,
//     this.isBackBtn = false,
//     this.isVisibleActions = true,
//   });
//
//   @override
//   Size get preferredSize => Size.fromHeight(height);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         decoration: const BoxDecoration(
//           color: AppColors.primary,
//           borderRadius: BorderRadius.only(
//             bottomLeft: Radius.circular(12),
//             bottomRight: Radius.circular(12),
//           ),
//         ),
//         padding: const EdgeInsets.all(8),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 isBackBtn
//                     ? IconButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                           color: AppColors.white,
//                         ),
//                       )
//                     : SizedBox.shrink(),
//                 Image.asset(AppAssets.appLogo, scale: 2.5),
//               ],
//             ),
//             SizedBox(height: title != null ? 2.h : 0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: title != null
//                   ? CrossAxisAlignment.center
//                   : CrossAxisAlignment.end,
//               children: [_leftSection(), _rightSection(context)],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _leftSection() {
//     final hasTitle = (title != null && title!.trim().isNotEmpty);
//     if (hasTitle) {
//       return CustomText(
//         text: title!,
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//         color: AppColors.white,
//       );
//     }
//     return Row(
//       children: [
//         Image.asset(AppAssets.appLogo, scale: 2.5),
//         const SizedBox(width: 8),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomText(
//               text: 'Welcome',
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w400,
//               color: AppColors.white,
//             ),
//             CustomText(
//               text: userName ?? '',
//               fontSize: 22.sp,
//               fontWeight: FontWeight.w600,
//               color: AppColors.white,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _rightSection(BuildContext context) {
//     return isVisibleActions
//         ? Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               CustomText(
//                 text: 'Last Sync: ${lastSyncText ?? "--:--"}',
//                 color: AppColors.white,
//                 fontSize: 12.sp,
//               ),
//               const SizedBox(width: 12),
//               GestureDetector(
//                 onTap: onSyncTap,
//                 child: Image.asset(AppAssets.iconSync, scale: 2.5),
//               ),
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap:
//                     onNotificationTap ??
//                     () => Get.toNamed(Routes.notifications),
//                 child: Image.asset(AppAssets.iconNotification, scale: 2.5),
//               ),
//               const SizedBox(width: 8),
//               GestureDetector(
//                 onTap: onLogoutTap ?? () => _showLogoutDialog(context),
//                 child: Image.asset(AppAssets.iconLogout, scale: 2.5),
//               ),
//             ],
//           )
//         : SizedBox.shrink();
//   }
//
//   void _showLogoutDialog(BuildContext context) {
//     showGeneralDialog(
//       context: context,
//       barrierLabel: 'Logout',
//       barrierDismissible: true,
//       barrierColor: Colors.black.withValues(alpha: 0.1),
//       pageBuilder: (context, a, b) => const SizedBox.shrink(),
//       transitionBuilder: (context, anim, b, child) {
//         return Center(
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               width: 85.w,
//               padding: EdgeInsets.all(16.sp),
//               decoration: BoxDecoration(
//                 color: AppColors.surfaceDark,
//                 borderRadius: BorderRadius.circular(12.sp),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomText(
//                     text: 'Logout',
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.white,
//                   ),
//                   SizedBox(height: 8.h),
//                   CustomText(
//                     text: 'Are you sure you want to logout?',
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.textSecondaryDark,
//                   ),
//                   SizedBox(height: 16.h),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: CustomButton(
//                           label: 'No',
//                           color: AppColors.fieldColor,
//                           onPressed: () => Navigator.of(context).pop(),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: CustomButton(
//                           label: 'Logout',
//                           color: AppColors.accentDark,
//                           onPressed: () async {
//                             final prefs = await SharedPreferences.getInstance();
//                             await prefs.clear();
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
