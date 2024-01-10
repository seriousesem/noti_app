import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/theme/app_colors.dart';
import '../../utils/images_assets.dart';
import 'button_text.dart';

buildSmallElevatedButtonWithIcon({
  required String buttonText,
  required String iconAssets,
  required Function() buttonAction,
}) {
  return Expanded(
    child: ElevatedButton(
      onPressed: buttonAction,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
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
                AppColors.mainWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
          buildButtonText(buttonText: buttonText),
        ],
      ),
    ),
  );
}
