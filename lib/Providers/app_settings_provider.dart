import 'dart:ui';
import 'package:families/Widgets/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/app_strings.dart';

class AppSettingsProvider extends ChangeNotifier with WidgetsBindingObserver {
  SharedPreferences? _prefs;
  Locale? _locale;
  Brightness? _theme;
  Size? _size;
  bool _autoDarkMode = false;
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
    _initializeSize();
    goToNextScreen();
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    pageController.dispose();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (!_autoDarkMode || _theme == null) return;
    _theme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    notifyListeners();
  }

  @override
  void didChangeMetrics() {
    _updateSize();
    notifyListeners();
  }

  Locale get locale => _locale ?? Locale(Intl.systemLocale);
  Brightness get theme => _theme ?? Brightness.light;
  bool get isDark => _theme == Brightness.dark;
  bool get autoDarkMode => _autoDarkMode;

  double get width => _size?.width ?? 0;
  double get height => _size?.height ?? 0;

  void _initializeLocale() async {
    String? savedLocaleCode = getData(key: PrefKeys.lang);

    _locale = savedLocaleCode != null
        ? Locale(savedLocaleCode)
        : Intl.getCurrentLocale().contains('ar')
            ? const Locale('ar')
            : const Locale('en');
    saveData(key: PrefKeys.lang, value: _locale!.languageCode);
  }

  void _initializeTheme() {
    _autoDarkMode = getData(key: PrefKeys.autoDarkMode) ?? false;

    if (_autoDarkMode) {
      _theme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    } else {
      bool? isDarkModeStored = getData(key: PrefKeys.isDark);
      if (isDarkModeStored is bool) {
        _theme = isDarkModeStored ? Brightness.dark : Brightness.light;
      } else {
        _theme = Brightness.light;
      }
    }
  }

  void _initializeSize() {
    _updateSize();
  }

  void _updateSize() {
    final FlutterView view =
        WidgetsBinding.instance.platformDispatcher.views.first;
    _size = view.physicalSize / view.devicePixelRatio;
  }

  // double fontSize(double fontSize) {
  //   double scaleFactor = getScaleFactor();
  //   double responsiveFontSize = fontSize * scaleFactor;
  //   double lowerLimit = fontSize * .8;
  //   double upperLimit = fontSize * 1.2;
  //   return responsiveFontSize.clamp(lowerLimit, upperLimit);
  // }

  double getScaleFactor() {
    double width = _size?.width ?? 550;
    if (width < 600) {
      return width / 400;
    } else {
      return width / 700;
    }
  }

  void toggleLocale(Locale newLocale) {
    if (!AppLocalizations.supportedLocales.contains(newLocale)) return;
    if (newLocale != _locale) {
      _locale = newLocale;
      saveData(key: PrefKeys.lang, value: newLocale.languageCode);
      notifyListeners();
    }
  }

  void toggleTheme() {
    if (_autoDarkMode) return; // Ignore if auto theme is enabled
    _theme = isDark ? Brightness.light : Brightness.dark;
    saveData(key: PrefKeys.isDark, value: isDark);
    notifyListeners();
  }

  void setAutoDarkMode(bool value) {
    _autoDarkMode = value;
    saveData(key: PrefKeys.autoDarkMode, value: value);
    if (_autoDarkMode) {
      _theme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    }
    notifyListeners();
  }

  void goToNextScreen() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        NavigationService.navigateToAndReplace(AppRoutes.selectLangScreen);
      },
    );
  }

  void getPageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  ////////////////////////////////////////////
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
