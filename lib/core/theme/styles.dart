import 'package:flutter/material.dart';

class AppSizes {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
}

class AppRadii {
  static const BorderRadius sm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius md = BorderRadius.all(Radius.circular(12));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(16));
}

class AppShadows {
  static const List<BoxShadow> soft = [
    BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
  ];
}
