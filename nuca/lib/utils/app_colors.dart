import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF960FFF);
  static const Color secondary = Color(0xFFF5E7FF);
  static const Color accentDark = Color(0xFF348AC7);
  static const Color accent = Color(0xFF79D0FF);

  static const Color textPrimary = Color(0xFF6C5CE7);
  static const Color textSecondary = Color(0xFF4F5B67);
  static const Color textSecondaryDark = Color(0xFFBFD1E5);
  static const Color hintTextGrey = Color(0xFFDDDADA);
  static const Color textGrey = Color(0xFF858585);
  static const Color textGrey1 = Color(0xFF9A9A9A);
  static const Color textGrey2 = Color(0xFF696F8C);

  static const Color cardBg = Color(0xFFF0F0F0);
  static const Color borderColor = Color(0xFFA8A8A8);


  static const Color surfaceDark = Color(0xFF15223A);
  static const Color fieldColor = Color(0xFF192A52);

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color error = Colors.redAccent;
  static const Color emergencyColor = Color(0xFFFFB7B8);
  static const Color success = Colors.green;

  final gradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF7ED6D3),
      Color(0xFFB77CF5),
      Color(0xFF9A9CF6),
    ],
  );
}
