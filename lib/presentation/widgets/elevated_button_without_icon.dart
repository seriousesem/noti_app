import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

buildElevatedButtonWithoutIcon({
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
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.mainWhite,
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
