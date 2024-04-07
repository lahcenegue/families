import 'package:flutter/material.dart';

abstract class AppSize {
  static double width(context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double height(context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double widthSize(double size, context) {
    double scaleFactor = getWidthScaleFactor(context);
    double responsiveWidthSize = size * scaleFactor;

    return responsiveWidthSize.clamp(size * 0.8, size * 1.4);
  }

  static double heightSize(double size, context) {
    double scaleFactor = getheightScaleFactor(context);
    double responsiveheightSize = size * scaleFactor;

    return responsiveheightSize.clamp(size * 0.8, size * 1.4);
  }

  static double fontSize(double size, context) {
    double scaleFactor = getWidthScaleFactor(context);
    double responsiveFontSize = size * scaleFactor;

    return responsiveFontSize.clamp(size * 0.8, size * 1.4);
  }

  static double iconSize(double size, context) {
    double scaleFactor = getWidthScaleFactor(context);
    double responsiveIconSize = size * scaleFactor;

    return responsiveIconSize.clamp(size * 0.8, size * 1.4);
  }
}

double getWidthScaleFactor(context) {
  double width = MediaQuery.sizeOf(context).width;

  return width / 375;
}

double getheightScaleFactor(context) {
  double height = MediaQuery.sizeOf(context).height;

  return height / 800;
}
