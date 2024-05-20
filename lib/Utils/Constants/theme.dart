import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xffffffff),
    primaryColor: Colors.black,

    // appBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
    ),

    // Text
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.black),
    ),

    // textFormField
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.fieldFillColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 12,
      ),
      hintStyle: TextStyle(color: AppColors.hintColor),
      labelStyle:
          const TextStyle(color: Colors.black), // Added for label text color
      floatingLabelStyle: const TextStyle(
          color: Colors.black), // Added for floating label text color

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
      errorStyle:
          const TextStyle(color: Colors.red), // Added for error text color
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
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return Colors.white;
          },
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    ),

    // TextButton theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.primaryColor.withOpacity(0.6);
          }
          return Colors.black;
        }),
      ),
    ),

    // OutlinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        minimumSize: const Size(double.infinity, 60),
        side: BorderSide(color: AppColors.primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: const Color(0xff9DB2CE),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkScaffoldBackground,
    primaryColor: Colors.white,

    // appBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // Text
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
    ),

    // textFormField
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.darkContainerBackground,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 12,
      ),
      hintStyle: TextStyle(color: AppColors.darkHintColor),
      labelStyle:
          const TextStyle(color: Colors.white), // Added for label text color
      floatingLabelStyle: const TextStyle(
          color: Colors.white), // Added for floating label text color
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.red),
      ),
      errorStyle:
          const TextStyle(color: Colors.red), // Added for error text color
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
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return Colors.black;
          },
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    ),

    // TextButton theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColors.primaryColor.withOpacity(0.6);
          }
          return Colors.white;
        }),
      ),
    ),

    // OutlinedButton
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        minimumSize: const Size(double.infinity, 60),
        side: BorderSide(color: AppColors.primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkContainerBackground,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: Colors.white,
    ),
  );
}
