import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/export.dart';
import '../history/history_view.dart';
import '../home/home_screen.dart';
 import '../settings/settings_view.dart';

class BottomNavController extends BaseController {
  final RxInt index = 0.obs;

  final List<Widget> tabs = <Widget>[
    const HomeView(),
    const HistoryView(),
    const SettingsView(),
  ];

  void setIndex(int value) {
    index.value = value;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
