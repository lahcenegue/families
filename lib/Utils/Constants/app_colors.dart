import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xFF02C543);
  static Color darkScaffoldBackground = const Color(0xFF263238);
  static Color fillColor = const Color(0xFF262931);
  static Color hintColor = const Color(0xFFA0A5BA);
  static Color darkHintColor = const Color(0xFFFFFFFF);
  static Color fieldFillColor = const Color(0xFFF0F5FA);
  static Color greyTextColors = const Color(0xFF9C9BA6);
  static Color starColor = const Color(0xFFE4B40A);
  static Color darkContainerBackground = const Color(0xFF455a64);
}

class MaterialColorGenerator {
  static MaterialColor from(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}
