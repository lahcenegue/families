import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData theme = ThemeData(
  fontFamily: 'Tajawal',
  brightness: Brightness.light,
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.backgroundColor,

  // text form feiled
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: AppColors.fieldFillColor,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 30,
      vertical: 12,
    ),
    hintStyle: TextStyle(color: AppColors.hintColor),
  ),

  //Elevated Button Style
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
      elevation: MaterialStateProperty.all(0),
      minimumSize: MaterialStateProperty.all(const Size(double.infinity, 60)),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ),

  // TextButton theme
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.primaryColor.withOpacity(0.6);
        }
        return Colors.white;
      }),
    ),
  ),
);
