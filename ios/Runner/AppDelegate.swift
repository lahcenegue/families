import UIKit
import Flutter
import OneSignalFramework

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Remove this method to stop OneSignal Debugging
    OneSignal.Debug.setLogLevel(.LL_VERBOSE)
    
    // OneSignal initialization
    OneSignal.initialize("Yfe34967e-ec5a-46c2-ad8e-62d61ed2cb12", withLaunchOptions: launchOptions)
    
    // requestPermission will show the native iOS notification permission prompt.
    // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission({ accepted in
      print("User accepted notifications: \(accepted)")
    }, fallbackToSettings: true)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}