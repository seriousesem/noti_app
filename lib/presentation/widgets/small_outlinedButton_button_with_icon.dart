import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/theme/app_colors.dart';
import 'button_text.dart';

buildSmallOutlinedButtonWithIcon({
  required String buttonText,
  required String iconAssets,
  required Function() buttonAction,
}) {
  return Expanded(
    child: OutlinedButton(
      onPressed: buttonAction,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.mainDark,
        backgroundColor: AppColors.veryLightGrey,
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: SvgPicture.asset(
              iconAssets,
              colorFilter: const ColorFilter.mode(
                AppColors.mainDark,
                BlendMode.srcIn,
              ),
            ),
          ),
          Text(
            buttonText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.mainDark,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}
