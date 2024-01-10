
import 'package:flutter/cupertino.dart';
import 'package:noti_app/core/theme/app_colors.dart';

buildButtonText({required String buttonText}){
  return Text(
    buttonText,
    textAlign: TextAlign.center,
    style: const TextStyle(
      color: AppColors.mainWhite,
      fontSize: 16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
    ),
  );
}