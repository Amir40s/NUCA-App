// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:text_to_voice_ai/utils/app_colors.dart';
// import 'package:text_to_voice_ai/utils/export.dart';
// import 'package:text_to_voice_ai/widgets/custom_text.dart';

// class PlatformImageSourceDialog {
//   static Future<ImageSource?> show(BuildContext context) async {
//     return Get.dialog<ImageSource>(
//       Platform.isIOS
//           ? CupertinoActionSheet(
//         title: AppTextWidget(text: 'Select Image Source', fontSize: 16, textAlign: TextAlign.center),
//         actions: [
//           CupertinoActionSheetAction(
//             child: AppTextWidget(text: 'Camera', fontSize: 16, textAlign: TextAlign.center),
//             onPressed: () => Get.back(result: ImageSource.camera),
//           ),
//           CupertinoActionSheetAction(
//             child: AppTextWidget(text: 'Gallery', fontSize: 16, textAlign: TextAlign.center),
//             onPressed: () => Get.back(result: ImageSource.gallery),
//           ),
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           child: AppTextWidget(text: 'Cancel', fontSize: 16, textAlign: TextAlign.center),
//           onPressed: () => Get.back(),
//         ),
//       )
//           : AlertDialog(
//         backgroundColor: AppColors.white,
//         title: AppTextWidget(text: 'Select Image Source', fontSize: 16, textAlign: TextAlign.center),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.camera_alt),
//               title: AppTextWidget(text: 'Camera', fontSize: 16, textAlign: TextAlign.start),
//               onTap: () => Get.back(result: ImageSource.camera),
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: AppTextWidget(text: 'Gallery', fontSize: 16, textAlign: TextAlign.start),
//               onTap: () => Get.back(result: ImageSource.gallery),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }
