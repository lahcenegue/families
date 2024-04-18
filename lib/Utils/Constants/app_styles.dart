import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppStyles {
  static TextStyle styleBold(double fontSize, context) {
    return TextStyle(
      fontFamily: 'UniqueBold',
      color: Colors.white,
      fontSize: AppSize.fontSize(fontSize, context),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleExtraBold(double fontSize, context) {
    return TextStyle(
      fontFamily: 'UniqueBold',
      color: AppColors.primaryColor,
      fontSize: AppSize.fontSize(fontSize, context),
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle styleRegular(double fontSize, context) {
    return TextStyle(
      fontFamily: 'UniqueLight',
      fontSize: AppSize.fontSize(fontSize, context),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleMedium(double fontSize, context) {
    return TextStyle(
      fontFamily: 'UniqueLight',
      fontSize: AppSize.fontSize(fontSize, context),
      fontWeight: FontWeight.w500,
    );
  }
}
