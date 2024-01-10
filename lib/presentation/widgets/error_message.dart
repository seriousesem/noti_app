import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_colors.dart';
import '../../utils/images_assets.dart';

buildErrorMessageWidget({required String errorMessage}) {
  return errorMessage.isNotEmpty
      ? Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: const BoxDecoration(color: Color(0xFFF3F3F4)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconsAssets.error,
                    colorFilter: const ColorFilter.mode(AppColors.mainRed, BlendMode.srcIn),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(
                        color: AppColors.mainRed,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      : const SizedBox.shrink();
}
