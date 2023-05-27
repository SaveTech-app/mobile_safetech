import 'package:flutter/material.dart';

import 'app_color.dart';

abstract class AppStyles {
  static double borderRadius = 30;
  static double borderWidth = 2;

  static BoxDecoration greyWithGreen = BoxDecoration(
    color: AppColors.terciaryColor,
    border: Border.all(
      color: AppColors.primaryColor,
      width: borderWidth,
    ),
    borderRadius: BorderRadius.circular(borderRadius),
  );
}
