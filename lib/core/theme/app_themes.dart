import 'package:flutter/material.dart';
import 'package:noti_app/core/theme/app_colors.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Roboto',
    appBarTheme: appBarTheme(),
    pageTransitionsTheme: pageTransitionsTheme(),
    elevatedButtonTheme: elevatedButtonTheme(),
    outlinedButtonTheme: outlinedButtonTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: AppColors.mainDark,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.mainWhite),
    titleTextStyle: TextStyle(
      color: AppColors.mainWhite,
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

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.greyB8;
            }
            if (states.contains(MaterialState.pressed)) {
              return AppColors.primaryPressed;
            }
            if (states.contains(MaterialState.hovered)) {
              return AppColors.primaryHover;
            }
            return AppColors.primaryActive;
          }),
          elevation: MaterialStateProperty.resolveWith((states) => null),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
              (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ))));
}

OutlinedButtonThemeData outlinedButtonTheme() {
  return OutlinedButtonThemeData(
      style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>((states) => const BorderSide(
            color: AppColors.primaryActive,
          )),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
              (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ))));
}
