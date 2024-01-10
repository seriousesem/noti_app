import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/theme/app_colors.dart';
import '../../utils/images_assets.dart';
import 'button_text.dart';

buildElevatedButtonWithIcon({
  required String buttonText,
  required bool isActive,
  required Function() buttonAction,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: isActive ? buttonAction : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SvgPicture.asset(
                      IconsAssets.addCircle,
                      colorFilter: const ColorFilter.mode(
                          AppColors.mainWhite, BlendMode.srcIn),
                    ),
                  ),
                  buildButtonText(buttonText: buttonText),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
