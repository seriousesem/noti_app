import 'package:flutter/material.dart';
import 'package:noti_app/core/theme/app_colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto',
    appBarTheme: appBarTheme(),
    pageTransitionsTheme: pageTransitionsTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: AppColors.dark17,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.white),
    titleTextStyle: TextStyle(
      color: AppColors.white,
      fontFamily: 'Roboto',
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 0.09,
    ),
  );
}

pageTransitionsTheme() {
  return const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
    },
  );
}
