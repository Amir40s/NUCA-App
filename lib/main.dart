import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuca/core/theme/app_theme.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: true,
      builder: (context) {
        return Sizer(
          builder: (context, orientation, screenType) {
            return GetMaterialApp(
              title: 'Nuca',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
            );
          },
        );
      },
    );
  }
}
