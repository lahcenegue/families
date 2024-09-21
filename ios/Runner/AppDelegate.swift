import UIKit
import Flutter
import OneSignal

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    OneSignal.Debug.setLogLevel(.LL_VERBOSE)
    OneSignal.initialize("fe34967e-ec5a-46c2-ad8e-62d61ed2cb12", withLaunchOptions: launchOptions)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
