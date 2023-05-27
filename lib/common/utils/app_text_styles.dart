// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'app_color.dart';

abstract class AppTextStyles {
  static TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle body = TextStyle(
    fontSize: 16,
  );

  static TextStyle buttonText = TextStyle(
    color: AppColors.myWhite,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}
