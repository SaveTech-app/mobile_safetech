import 'package:flutter/material.dart' show Color, Colors;

abstract class AppColors {
  //brand colors
  static const Color _blue = Color(0xFF37629D);
  static const Color _darkBlue = Color(0xFF232322);
  static const Color _grey = Color(0xFFF4F4F4);

  //stateColors
  static const Color _error = Color(0xFFEB5757);
  static const Color _warning = Color(0xFFE2B93B);

  //app colors
  static const Color primaryColor = _blue;
  static const Color secundaryColor = _darkBlue;
  static const Color terciaryColor = _grey;

  static const Color errorColor = _error;
  static const Color warningColor = _warning;

  static const Color myWhite = Colors.white;
  static const Color myBlack = Colors.black;
}
