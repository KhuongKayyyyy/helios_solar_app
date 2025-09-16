import 'package:flutter/material.dart';
import 'package:helios/core/constants/color_constants.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: ColorConstants.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: ColorConstants.white,
      ),
    );
  }
}
