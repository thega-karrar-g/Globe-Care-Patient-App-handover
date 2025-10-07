import UIKit
import Flutter
import GoogleMaps
import Urway
import Firebase
// import Messaging

@main
@objc class AppDelegate: FlutterAppDelegate {

  //  var window: UIWindow?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
          FirebaseApp.configure()

    GMSServices.provideAPIKey("AIzaSyC1bJKIoRtsp0CbTSYKgBTT9YgtgZ8c2TI")

      //  UNUserNotificationCenter.current().delegate = self
       // application.registerForRemoteNotifications()
        //return super.application(application, didFinishLaunchingWithOptions: launchOptions)

     GeneratedPluginRegistrant.register(with: self)
            application.registerForRemoteNotifications()

     return super.application(application, didFinishLaunchingWithOptions: launchOptions)


//  let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
//         self.window?.rootViewController = UINavigationController(rootViewController: controller)
//         return true

  }


    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
}


//
// //
// //  AppDelegate.swift
// //  UrwayDemoApp
// //
// //
//
// // import UIKit
// // import Urway
//
// @UIApplicationMain
// class AppDelegate: UIResponder, UIApplicationDelegate {
//
//     var window: UIWindow?
//
//     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//         // Override point for customization after application launch.
//
//            GMSServices.provideAPIKey("AIzaSyC1bJKIoRtsp0CbTSYKgBTT9YgtgZ8c2TI")
// // if #available(iOS 13.0, *) {
// //
// //         let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as ViewController
// //         self.window?.rootViewController = UINavigationController(rootViewController: controller)
// // }
// // else{
// //
// //  let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as ViewController
// //         self.window?.rootViewController = UINavigationController(rootViewController: controller)
// //
// //
// // }
//
// //
// // let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as ViewController
// //         self.window?.rootViewController = UINavigationController(rootViewController: controller)
// //
//
//
//
// // if #available(iOS 13.0, *) {
// //         let vc = storyboard.instantiateViewController(identifier: "doctorProfileVC") as DrProfileViewController
// //         self.navigationController?.pushViewController(vc, animated: true)
// //
// //     } else {
// //         let vc = storyboard.instantiateViewController(withIdentifier: "storyboard.instantiateViewController") as! DrProfileViewController
// //         self.navigationController?.pushViewController(vc, animated: true)
// //     }
//
// let mainSB: UIStoryBoard = (name: "Main", bundle: Bundle.main)
// let objVC = mainSB.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//
//         return true
//     }
//
//
//
//
// }
