
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_colors.dart';
import '../../utils/images_assets.dart';

buildButtonBackWidget({required BuildContext context}){
  return SizedBox(
    width: 44,
    height: 44,
    child: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      padding: EdgeInsets.zero,
      icon: SvgPicture.asset(
        IconsAssets.arrowBackIos,
        colorFilter: const ColorFilter.mode(
            AppColors.mainWhite, BlendMode.srcIn),
      ),
    ),
  );
}