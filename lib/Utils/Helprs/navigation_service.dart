import 'package:families/Screens/Family/family_home_screen.dart';
import 'package:families/Screens/Start/Login/login_screen.dart';
import 'package:families/Screens/Start/Register/family_register_screen.dart';
import 'package:families/Screens/Start/Register/register_screen.dart';
import 'package:families/Screens/Start/account_type/account_type.dart';
import 'package:families/Screens/Start/onbording/onbording_screen.dart';
import 'package:families/Screens/User/orders_details.dart';
import 'package:families/Screens/User/product_details.dart';
import 'package:families/Screens/User/user_home_screen.dart';
import 'package:flutter/material.dart';
import '../../../Screens/Start/splash/splash.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String selectLangScreen = '/selectLang';
  static const String onBordingScreen = '/onBordingScreen';
  static const String accountTypeScreen = '/accountType';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String registerFamilyScreen = '/registerFamilyScreen';
  static const String userHomeScreen = '/userHomeScreen';
  static const String familyHomeScreen = '/familyHomeScreen';
  static const String productDetails = '/productsDetails';
  static const String ordersDetails = '/ordersDetails';

  static Map<String, WidgetBuilder> define() {
    return {
      splashScreen: (BuildContext context) => const SplashScreen(),
      accountTypeScreen: (BuildContext context) => const AccountType(),
      onBordingScreen: (BuildContext context) => const OnBordingScreen(),
      loginScreen: (BuildContext context) => const LoginScreen(),

      ///////////
      ///
      // selectLangScreen: (BuildContext context) => const SelectLanguage(),
      // registerScreen: (BuildContext context) => const RegisterScreen(),
      // registerFamilyScreen: (BuildContext context) =>
      //     const RegisterFamilyScreen(),
      // userHomeScreen: (BuildContext context) => const UserHomeScreen(),
      // familyHomeScreen: (BuildContext context) => const FamilyHomeScreen(),
      // productDetails: (BuildContext context) => const ProductDetails(),
      // ordersDetails: (BuildContext context) => const OrdersDetails(),
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
