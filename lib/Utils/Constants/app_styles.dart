import 'package:families/Utils/Constants/app_size.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppStyles {
  static TextStyle styleBold(double fontSize, context) {
    return TextStyle(
      color: Colors.white,
      fontSize: AppSize.fontSize(fontSize, context),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleExtraBold(context, double fontSize) {
    return TextStyle(
      color: AppColors.primaryColor,
      fontSize: AppSize.fontSize(fontSize, context),
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle styleRegular(context, double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: AppSize.fontSize(fontSize, context),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleMedium(context, double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: AppSize.fontSize(fontSize, context),
      fontWeight: FontWeight.w500,
    );
  }
}
