import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuca/core/theme/app_theme.dart';
import 'package:nuca/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
