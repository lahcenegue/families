import 'package:flutter/material.dart';

import '../../Screens/Family/add_dish.dart';
import '../../Screens/Family/family_home_screen.dart';
import '../../Screens/Family/my_dishs.dart';
import '../../Screens/Family/term_condition.dart';
import '../../Screens/Start/Register/family_register_screen.dart';
import '../../Screens/Start/Splash/splash.dart';
import '../../Screens/Start/Login/login_screen.dart';
import '../../Screens/Start/Otp/otp_screen.dart';
import '../../Screens/Start/Register/register_screen.dart';
import '../../Screens/Start/Account_type/account_type.dart';
import '../../Screens/Start/Congratulations/congratulations_screen.dart';
import '../../Screens/Start/Onbording/onbording_screen.dart';
import '../../Screens/Start/Reset_password/reset_password.dart';
import '../../Screens/User/Screens/dish_view.dart';
import '../../Screens/User/Screens/feedbacks_screen.dart';
import '../../Screens/User/Screens/store_view.dart';
import '../../Screens/User/Screens/terms_conditions_user.dart';
import '../../Screens/User/Screens/user_all_messages.dart';
import '../../Screens/User/Screens/user_home_screen.dart';
import '../../Screens/User/Widgets/custom_search_page.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String accountTypeScreen = '/accountType';
  static const String onBordingScreen = '/onBordingScreen';
  static const String loginScreen = '/loginScreen';
  static const String registerScreen = '/registerScreen';
  static const String familyRegisterScreen = '/familyRegisterScreen';
  static const String otpScreen = '/otpScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String congratulationsScreen = '/congratulationsScreen';
  static const String userHomeScreen = '/userHomeScreen';
  static const String storeView = '/storeView';
  static const String disheView = '/disheView';
  static const String familyHomeScreen = '/familyHomeScreen';
  static const String searchScreen = '/search';
  static const String feedbackScreen = '/feedbackScreen';
  static const String addNewDish = '/addNewDish';
  static const String familyTermsConditions = '/familyTermsConditions';
  static const String userTermsConditions = '/userTermsConditions';
  static const String userAllMessages = '/userallMessages';
  static const String myDishsScreen = '/myDishsScreen';

  static Map<String, WidgetBuilder> define() {
    return {
      splashScreen: (BuildContext context) => const SplashScreen(),
      accountTypeScreen: (BuildContext context) => const AccountType(),
      onBordingScreen: (BuildContext context) => const OnBordingScreen(),
      loginScreen: (BuildContext context) => const LoginScreen(),
      registerScreen: (BuildContext context) => const RegisterScreen(),
      familyRegisterScreen: (BuildContext context) =>
          const FamilyRegisterScreen(),
      otpScreen: (BuildContext context) => const OtpScreen(),
      resetPasswordScreen: (BuildContext context) =>
          const ResetPasswordScreen(),
      congratulationsScreen: (BuildContext context) =>
          const CongratulationsScreen(),
      userHomeScreen: (BuildContext context) => const UserHomeScreen(),
      storeView: (BuildContext context) => const StoreView(),
      disheView: (BuildContext context) => const DisheView(),
      searchScreen: (BuildContext context) => const CustomSearchPage(),
      feedbackScreen: (BuildContext context) => const FeedbacksScreen(),
      familyHomeScreen: (BuildContext context) => const FamilyHomeScreen(),
      addNewDish: (BuildContext context) => const AddNewDish(),
      familyTermsConditions: (BuildContext context) =>
          const FamilyTermsAndConditionsPage(),
      userTermsConditions: (BuildContext context) =>
          const UserTermsAndConditionsPage(),
      userAllMessages: (BuildContext context) => const UserAllMessages(),
      myDishsScreen: (BuildContext context) => const MyDishsScreen(),
    };
  }
}

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName) {
    try {
      return navigatorKey.currentState!.pushNamed(routeName);
    } catch (e) {
      debugPrint("Navigation error: $e");
      return Future.value(null);
    }
  }

  static Future<dynamic> navigateToAndReplace(String routeName) {
    try {
      return navigatorKey.currentState!
          .pushNamedAndRemoveUntil(routeName, (route) => false);
    } catch (e) {
      debugPrint("Navigation error: $e");
      return Future.value(null);
    }
  }

  static void goBack() {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    }
  }
}
