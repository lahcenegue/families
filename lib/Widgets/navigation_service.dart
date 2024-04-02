import 'package:families/Screens/Login/login_screen.dart';
import 'package:families/Screens/Register/family_register_screen.dart';
import 'package:families/Screens/Register/register_screen.dart';
import 'package:families/Screens/account_type/account_type.dart';
import 'package:families/Screens/lang/select_language.dart';
import 'package:families/Screens/onbording/onbording_screen.dart';
import 'package:flutter/material.dart';
import '../Screens/splash/splash.dart';

class AppRoutes {
  static const String splash = '/';
  static const String selectLang = '/selectLang';
  static const String onBordingScreen = '/onBordingScreen';
  static const String accountType = '/accountType';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String registerFamilyScreen = '/registerFamilyScreen';

  static Map<String, WidgetBuilder> define() {
    return {
      splash: (BuildContext context) => const SplashScreen(),
      selectLang: (BuildContext context) => const SelectLanguage(),
      onBordingScreen: (BuildContext context) => const OnBordingScreen(),
      accountType: (BuildContext context) => const AccountType(),
      loginScreen: (BuildContext context) => const LoginScreen(),
      registerScreen: (BuildContext context) => const RegisterScreen(),
      registerFamilyScreen: (BuildContext context) =>
          const RegisterFamilyScreen(),
    };
  }
}

/////////

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static Future<dynamic> navigateToAndReplace(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  static void goBack() {
    navigatorKey.currentState!.pop();
  }
}
