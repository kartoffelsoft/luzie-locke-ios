//
//  AppDelegate.swift
//  luzie-locke-ios
//
//  Created by Harry on 09.10.21.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    #if DEBUG
      print("⚠️ [APP RUNS WITH DEBUG MODE] ⚠️")
    #endif
    
    FirebaseApp.configure()
    
    Messaging.messaging().delegate              = self
    UNUserNotificationCenter.current().delegate = self
    
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
      guard success else { return }
      
      print("Success in APNS registry")
    }
    
    application.registerForRemoteNotifications()
    
    UIBarButtonItem.appearance().tintColor = CustomUIColors.primaryColor
    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: CustomUIFonts.body], for: UIControl.State.normal)
    
    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [
      NSAttributedString.Key.font: CustomUIFonts.body,
      NSAttributedString.Key.foregroundColor: CustomUIColors.primaryColor
    ]
    
    return true
  }
  
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    messaging.token { token, _ in
      guard let _ = token else {
        return
      }
    }
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
  func application(
    _ app: UIApplication,
    open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
  ) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}
