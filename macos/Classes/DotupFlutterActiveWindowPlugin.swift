import Cocoa
import FlutterMacOS

public class DesktopActiveWindowPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "desktop_active_window", binaryMessenger: registrar.messenger)
    let instance = DesktopActiveWindowPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getActiveWindowInfo":
      let r = getWindowInfo()
      result(r);
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
