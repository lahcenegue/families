import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/Constants/app_strings.dart';
import '../Utils/Helprs/navigation_service.dart';

class AppSettingsProvider extends ChangeNotifier with WidgetsBindingObserver {
  SharedPreferences? _prefs;

  static const String _oneSignalAppId = 'fe34967e-ec5a-46c2-ad8e-62d61ed2cb12';

  Brightness? _theme;
  bool _autoDarkMode = true;
  late PageController pageController;
  int pageIndex = 0;

  String? _osUserID;
  String? get osUserID => _osUserID;

  AppSettingsProvider() {
    WidgetsBinding.instance.addObserver(this);
    _initializeAsync();
  }

  Future<void> _initializeAsync() async {
    _prefs = await SharedPreferences.getInstance();
    pageController = PageController(initialPage: 0);

    await Future.wait([
      _initializeTheme(),
      _initializeNotifications(),
    ]);

    pageIndex = 0;

    notifyListeners();
    goToNextScreen();
  }

  Future<void> _initializeNotifications() async {
    await _requestNotificationPermission();
    await _initializeOneSignal();
  }

  Future<void> _requestNotificationPermission() async {
    final context = NavigationService.navigatorKey.currentContext;
    if (context != null &&
        (Theme.of(context).platform == TargetPlatform.android ||
            Theme.of(context).platform == TargetPlatform.iOS)) {
      final status = await Permission.notification.request();
      debugPrint('Notification permission status: $status');
    }
  }

  Future<void> _initializeOneSignal() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Debug.setAlertLevel(OSLogLevel.none);

    OneSignal.initialize(_oneSignalAppId);
    await OneSignal.Notifications.clearAll();

    OneSignal.User.pushSubscription.addObserver((state) {
      _updateOSUserID(state.current.id);
    });

    OneSignal.Notifications.addPermissionObserver((state) {
      debugPrint('Notification permission state changed: $state');
    });

    OneSignal.Notifications.addClickListener(_handleNotificationClick);
    OneSignal.Notifications.addForegroundWillDisplayListener(
        _handleForegroundNotification);

    await OneSignal.Notifications.requestPermission(true);

    // Initial ID fetch
    _updateOSUserID(OneSignal.User.pushSubscription.id);
  }

  void _updateOSUserID(String? newID) {
    if (newID != null && newID.isNotEmpty && newID != _osUserID) {
      _osUserID = newID;
      saveData(key: PrefKeys.onSignalID, value: _osUserID!);
      notifyListeners();

      // If the user is already logged in, update the ID on your server
      _updateServerWithNewOSUserID();
    }
  }

  Future<void> _updateServerWithNewOSUserID() async {
    final token = _prefs?.getString(PrefKeys.token);
    if (token != null) {
      debugPrint('Token or OneSignal ID is null. Skipping update.');
      return;
      // Implement the API call to update the OneSignal ID on your server
      // For example:
      // await updateUserOneSignalID(token: token, oneSignalID: _osUserID);
    }
  }

  void _handleNotificationClick(OSNotificationClickEvent event) {
    debugPrint('Notification clicked:');
    debugPrint('Notification ID: ${event.notification.notificationId}');
    debugPrint('Title: ${event.notification.title}');
    debugPrint('Body: ${event.notification.body}');
    // Handle notification click (e.g., navigate to a specific screen)
  }

  void _handleForegroundNotification(OSNotificationWillDisplayEvent event) {
    debugPrint('Notification will display in foreground:');
    debugPrint('Notification ID: ${event.notification.notificationId}');
    debugPrint('Title: ${event.notification.title}');
    debugPrint('Body: ${event.notification.body}');

    // Decide whether to show the notification or not
    // event.preventDefault(); // Uncomment to prevent automatic display
    event.notification.display(); // Display the notification
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

  Future<void> _initializeTheme() async {
    _autoDarkMode = getData(key: PrefKeys.autoDarkMode) ?? true;

    if (_autoDarkMode) {
      _theme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    } else {
      bool isDarkModeStored = getData(key: PrefKeys.isDark) ?? false;
      _theme = isDarkModeStored ? Brightness.dark : Brightness.light;
    }
  }

  void toggleTheme() {
    saveData(key: PrefKeys.autoDarkMode, value: false);
    _theme = isDark ? Brightness.light : Brightness.dark;
    saveData(key: PrefKeys.isDark, value: isDark);
    notifyListeners();
  }

  void goToNextScreen() {
    final onBoarding = getData(key: PrefKeys.onBording);
    final accountType = getData(key: PrefKeys.accountType);
    final token = getData(key: PrefKeys.token);

    if (onBoarding == null) {
      NavigationService.navigateToAndReplace(AppRoutes.onBordingScreen);
    } else {
      if (token == null) {
        NavigationService.navigateToAndReplace(AppRoutes.userHomeScreen);
      } else {
        if (accountType == AppStrings.family) {
          NavigationService.navigateToAndReplace(AppRoutes.familyHomeScreen);
        } else {
          NavigationService.navigateToAndReplace(AppRoutes.userHomeScreen);
        }
      }
    }
  }

  void setPageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

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

    await _prefs?.remove(key);
    notifyListeners();
  }

  Future<void> clearAllNotifications() => OneSignal.Notifications.clearAll();
}
