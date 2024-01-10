import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/images_assets.dart';

buildNotificationWidget({
  required String time,
  required String message,
  String? iconAssets,
  String? iconBackgroundColor,
  required Function() editButtonAction,
  required Function() deleteButtonAction,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    child: Container(
      decoration: ShapeDecoration(
        color: AppColors.blueGrey,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.primaryActive),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: editButtonAction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      iconAssets != null
                      ? Column(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: ShapeDecoration(
                              color: iconBackgroundColor != null
                              ? iconBackgroundColors[iconBackgroundColor]
                              : Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: AppColors.darkGrey),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: SvgPicture.asset(
                                iconAssets,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.primaryActive, BlendMode.srcIn),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      )
                      : const SizedBox.shrink(),
                      Row(
                        children: [
                          const Text(
                            WidgetsText.time,
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            time,
                            style: const TextStyle(
                              color: AppColors.mainDark,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    onPressed: deleteButtonAction,
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      IconsAssets.deleteForever,
                      colorFilter: const ColorFilter.mode(
                          AppColors.mainRed, BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: editButtonAction,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    WidgetsText.message,
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    // width: 200,
                    child: Text(
                      message,
                      maxLines: 5,
                      style: const TextStyle(
                        color: AppColors.mainDark,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
