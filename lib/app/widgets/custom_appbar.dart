// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../utils/app_colors.dart';
// import 'custom_text.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final VoidCallback? onBack;
//   final bool showBack;
//   final Color backgroundColor;
//   final Color titleColor;

//   const CustomAppBar({
//     Key? key,
//     required this.title,
//     this.onBack,
//     this.showBack = true,
//     this.backgroundColor = Colors.white,
//     this.titleColor = Colors.black,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: backgroundColor,
//       surfaceTintColor: backgroundColor,
//       elevation: 0,
//       centerTitle: true,
//       leading: showBack
//           ? GestureDetector(
//         onTap: onBack ?? () => Get.back(),
//         child: Container(
//           margin: const EdgeInsets.all(8),
//           decoration: const BoxDecoration(
//             color: AppColors.secondary,
//             shape: BoxShape.circle,
//           ),
//           child: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//             size: 20,
//           ),
//         ),
//       )
//           : null,
//       title: AppTextWidget(
//         text: title,
//         color: titleColor,
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
