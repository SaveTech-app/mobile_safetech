import 'package:flutter/material.dart';

import 'app_color.dart';

abstract class AppTextStyles {
  static TextStyle title({Color? textColor}) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      );

  static TextStyle body({Color? textColor}) => TextStyle(
        fontSize: 16,
        color: textColor,
      );

  static TextStyle buttonText({Color? textColor}) => TextStyle(
        color: textColor ?? AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
}
