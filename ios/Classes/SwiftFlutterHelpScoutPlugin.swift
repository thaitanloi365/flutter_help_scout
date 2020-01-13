import Flutter
import UIKit
import Beacon
public class SwiftFlutterHelpScoutPlugin: NSObject, FlutterPlugin, HSBeaconDelegate {
    private var settings: HSBeaconSettings!;
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_help_scout", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterHelpScoutPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func prefill(_ form: HSBeaconContactForm) {
        guard let user = HSBeacon.currentUser() else {
            return
        }
        
        if let email = user.email {
            form.email = email
        }
        
        if let name = user.name {
            form.name = name
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "init") {

            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(FlutterError(code: "5000", message: "Invalid arguments", details: nil))
                return
            }
            
            guard let id = args["id"] as? String else {
                result(FlutterError(code: "4220", message: "Beacon id is required", details: nil))
                return
            }
            
             
            settings = HSBeaconSettings(beaconId: id)


            if let clearAttributes = args["clearAttributes"] as? Bool, clearAttributes == true {
                HSBeacon.currentUser()?.clearAttributes();
            }

            if let title = args["title"] as? String, title != "" {
                settings.beaconTitle = title
            }
            

            result(String(format: "Init susccess: id = %s",id));
            
        }else if(call.method == "open") {
            if settings == nil {
                result(FlutterError(code: "5000", message: "Init must be called first", details: nil))
            }
            HSBeacon.open(settings)
            result("Open settings susccess");
            
        }else if(call.method == "identify") {
            guard let args = call.arguments as? Dictionary<String, Any> else {
                result(FlutterError(code: "5000", message: "Invalid arguments", details: nil))
                return
            }
            
            guard let email = args["email"] as? String else {
                result(FlutterError(code: "4220", message: "Email is required", details: nil))
                return
            }
            
            guard let name = args["name"] as? String else {
                result(FlutterError(code: "4220", message: "Name is required", details: nil))
                return
            }
            
            let user = HSBeaconUser()
            user.email = email
            user.name = name
            if let attrs = args["attributes"] as? Dictionary<String, String> {
                for (key, value) in attrs {
                    if(key == "email" || key == "name") {
                        continue;
                    }
                    user.addAttribute(withKey: key, value: value)
                    
                }
            }
            let msg = "Login susccess: email = \(email), name =\(name)"
            HSBeacon.login(user)
            result(msg);
            
        }else if(call.method == "logout") {
            HSBeacon.logout()
            result("Loout susccess");
        }else {
            result(FlutterMethodNotImplemented);
        }
    }
    
    
}
