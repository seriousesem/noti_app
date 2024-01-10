import 'package:flutter/material.dart';
import 'button_text.dart';

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
              child: buildButtonText(buttonText: buttonText),
            ),
          ),
        ),
      ],
    ),
  );
}
