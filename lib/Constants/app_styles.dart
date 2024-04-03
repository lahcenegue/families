import 'package:families/Constants/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppStyles {
  static TextStyle styleBold(context, double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: getFontSize(context, fontSize),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleExtraBold(context, double fontSize) {
    return TextStyle(
      color: AppColors.primaryColor,
      fontSize: getFontSize(context, fontSize),
      fontWeight: FontWeight.w900,
    );
  }

  static TextStyle styleRegular(context, double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: getFontSize(context, fontSize),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleMedium(context, double fontSize) {
    return TextStyle(
      color: Colors.white,
      fontSize: getFontSize(context, fontSize),
      fontWeight: FontWeight.w500,
    );
  }
}

double getFontSize(context, double fontSize) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;
  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.4;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < 600) {
    return width / 400;
  } else {
    return width / 600;
  }
}
