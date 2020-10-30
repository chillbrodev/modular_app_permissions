import Flutter
import UIKit

public class SwiftModularPermissionsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ch.upte.modular_permissions", binaryMessenger: registrar.messenger())
    let instance = SwiftModularPermissionsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "openAppSettings" {
         guard let url = URL(string: UIApplication.openSettingsURLString) else {
               print("Invalid APP URL")
               return
         }
         print(url)
         if #available(iOS 10.0, *) {
           UIApplication.shared.open(url, options: [:], completionHandler: { success in
               print("Open app settings success: \(success)")
           })
         } else {
           // Fallback on earlier versions
           UIApplication.shared.openURL(url)
         }
     }
  }
}
