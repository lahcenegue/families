import 'package:families/Utils/Helprs/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Constants/app_strings.dart';

class AppSettingsProvider extends ChangeNotifier with WidgetsBindingObserver {
  SharedPreferences? _prefs;
  Locale? _locale;
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
    _initializeLocale();
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

  Locale get locale => _locale ?? Locale(Intl.systemLocale);
  Brightness get theme => _theme ?? Brightness.light;
  bool get isDark => _theme == Brightness.dark;
  bool get autoDarkMode => _autoDarkMode;

  void _initializeLocale() async {
    String? savedLocaleCode = getData(key: PrefKeys.lang);

    if (savedLocaleCode != null) {
      _locale = Locale(savedLocaleCode);
    } else {
      _locale = Intl.getCurrentLocale().contains('ar')
          ? const Locale('ar')
          : const Locale('en');
    }

    saveData(key: PrefKeys.lang, value: _locale!.languageCode);
  }

  void _initializeTheme() {
    _autoDarkMode = getData(key: PrefKeys.autoDarkMode) ?? true;

    if (_autoDarkMode) {
      _theme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    } else {
      bool? isDarkModeStored = getData(key: PrefKeys.isDark);
      _theme = (isDarkModeStored ?? false) ? Brightness.dark : Brightness.light;
    }
  }

  void toggleLocale(Locale newLocale) {
    if (AppLocalizations.supportedLocales.contains(newLocale) &&
        newLocale != _locale) {
      _locale = newLocale;
      saveData(key: PrefKeys.lang, value: newLocale.languageCode);
      notifyListeners();
    }
  }

  void toggleTheme() {
    saveData(key: PrefKeys.autoDarkMode, value: false);
    _theme = isDark ? Brightness.light : Brightness.dark;
    saveData(key: PrefKeys.isDark, value: isDark);
    notifyListeners();
  }

  // void setAutoDarkMode(bool value) {
  //   _autoDarkMode = value;
  //   saveData(key: PrefKeys.autoDarkMode, value: value);
  //   if (_autoDarkMode) {
  //     _theme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  //   }
  //   notifyListeners();
  // }

  void goToNextScreen() {
    print('========== Go to Next Screen ===============');
    Future.delayed(const Duration(seconds: 1), () {
      final accountType = getData(key: PrefKeys.accountType);
      final token = getData(key: PrefKeys.token);

      if (accountType == null || token == null) {
        NavigationService.navigateToAndReplace(AppRoutes.accountTypeScreen);
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
