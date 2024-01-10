import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color mainDark = Color(0xFF1A1717);
  static const Color darkGrey = Color(0xFF747377);
  static const Color gray = Color(0xFFB9B9B9);
  static const Color greyB8 = Color(0xFFB8B8B8);
  static const Color lightGrey = Color(0xFFE6E6E6);
  static const Color veryLightGrey = Color(0xFFF3F3F4);
  static const Color mainWhite = Color(0xFFFFFFFF);
  static const Color primaryPressed = Color(0xFF4B2AA5);
  static const Color primaryActive = Color(0xFF6A4DBA);
  static const Color primaryHover = Color(0xFF9279D7);
  static const Color veryLightBlue = Color(0xFFF1F4FF);
  static const Color blueGrey = Color(0xFFF8FAFB);
  static const Color lightViolet = Color(0xFFF5F1FF);
  static const Color mainRed = Color(0xFFF43528);
  static const Color lightPink = Color(0xFFFFF1F1);
  static const Color mainPink = Color(0xFFFFF1FF);
  static const Color lightYellow = Color(0xFFFFFEF1);
}

abstract class IconBackgroundColorsNames {
  static const String veryLightBlue = 'very_light_blue';
  static const String lightPink = 'light_pink';
  static const String lightYellow = 'light_yellow';
  static const String lightViolet = 'light_violet';
  static const String mainPink = 'main_pink';
}

const Map<String, Color> iconBackgroundColors = {
  IconBackgroundColorsNames.veryLightBlue: AppColors.veryLightBlue,
  IconBackgroundColorsNames.lightPink: AppColors.lightPink,
  IconBackgroundColorsNames.lightYellow: AppColors.lightYellow,
  IconBackgroundColorsNames.lightViolet: AppColors.lightViolet,
  IconBackgroundColorsNames.mainPink: AppColors.mainPink,
};
