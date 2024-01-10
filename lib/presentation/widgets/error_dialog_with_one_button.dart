import 'package:flutter/material.dart';

import '../../utils/constants.dart';

buildErrorDialogWithOneButton({
  required String error,
  required Function() yesButtonAction,
}) {
  return AlertDialog(
    title: const Text(
      Titles.errorDialog,
      textAlign: TextAlign.center,
    ),
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    ),
    content: Row(
      children: [
        Expanded(
          child: Text(
            error,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    contentTextStyle: const TextStyle(
      fontSize: 14,
      color: Colors.black54,
    ),
    actions: [
      Row(
        children: [
          const Spacer(flex: 1),
          Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: yesButtonAction,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ) ,
              ),
              child: const Text(WidgetsText.yes),
            ),
          ),
          const Spacer(flex: 1),
        ],
      ),
    ],
  );
}
