import 'package:flutter/material.dart';
import '../Screens/splash/splash.dart';

class AppRoutes {
  static const String splash = '/';

  static Map<String, WidgetBuilder> define() {
    return {
      splash: (BuildContext context) => const SplashScreen(),
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
