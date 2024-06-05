import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Constants/app_strings.dart';
import '../Utils/Helprs/navigation_service.dart';

class AppSettingsProvider extends ChangeNotifier with WidgetsBindingObserver {
  SharedPreferences? _prefs;

  Brightness? _theme;
  bool _autoDarkMode = true;
  late PageController pageController;
  int pageIndex = 0;

  AppSettingsProvider() {
    WidgetsBinding.instance.addObserver(this);
    initializeAsync();
  }

  Future<void> initializeAsync() async {
    _prefs = await SharedPreferences.getInstance();
    pageController = PageController(initialPage: 0);

    _initializeTheme();
    goToNextScreen();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    pageController.dispose();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (_autoDarkMode) {
      _theme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      notifyListeners();
    }
  }

  Brightness get theme => _theme ?? Brightness.light;
  bool get isDark => _theme == Brightness.dark;
  bool get autoDarkMode => _autoDarkMode;

  void _initializeTheme() {
    _autoDarkMode = getData(key: PrefKeys.autoDarkMode) ?? true;

    if (_autoDarkMode) {
      _theme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    } else {
      bool? isDarkModeStored = getData(key: PrefKeys.isDark);
      _theme = (isDarkModeStored ?? false) ? Brightness.dark : Brightness.light;
    }
    notifyListeners();
  }

  void toggleTheme() {
    saveData(key: PrefKeys.autoDarkMode, value: false);
    _theme = isDark ? Brightness.light : Brightness.dark;
    saveData(key: PrefKeys.isDark, value: isDark);
    notifyListeners();
  }

  void goToNextScreen() {
    print('========== Go to Next Screen ===============');
    Future.delayed(const Duration(seconds: 1), () {
      final accountType = getData(key: PrefKeys.accountType);
      final token = getData(key: PrefKeys.token);

      if (accountType == null || token == null) {
        NavigationService.navigateToAndReplace(AppRoutes.onBordingScreen);
        return;
      }

      if (accountType == AppStrings.family) {
        NavigationService.navigateToAndReplace(AppRoutes.familyHomeScreen);
      } else {
        NavigationService.navigateToAndReplace(AppRoutes.userHomeScreen);
      }
    });
  }

  void getPageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  // use Cach
  dynamic getData({required String key}) {
    return _prefs?.get(key);
  }

  Future<void> saveData({required String key, required dynamic value}) async {
    if (_prefs == null) return;

    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    }

    notifyListeners();
  }

  Future<void> removeData({required String key}) async {
    if (_prefs == null) return;
    await _prefs!.remove(key);
    notifyListeners();
  }
}
