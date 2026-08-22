//
//  AppDelegate.swift
//  nvecta-ios-sdk-example-app
//
//  Created by Notifyvisitors Macbook Pro 001  on 14/08/26.
//

import UIKit
import UserNotifications
import NVECTASDK
//import notifyvisitors


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var nvMode:String? = nil

         #if DEBUG
             nvMode = "debug"
         #else
             nvMode = "live"
        #endif
        
      //  notifyvisitors.initialize(nvMode)
       // notifyvisitors.registerPush(withDelegate: self, app: application, launchOptions: launchOptions)
        
        NVECTA.shared.register(mode: nvMode!)
        
        
        NVECTA.shared.registerPush(delegate: self, application: application, launchOptions: launchOptions)
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NVECTA.shared.didRegisterPushToken(application, token: deviceToken)
       // notifyvisitors.didRegisteredNotification(application, deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: any Error) {
        print("push registration failed due to the following error = \(error)" )
    }
   
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        NVECTA.shared.applicationDidEnterBackground(application)
      //  notifyvisitors.applicationDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NVECTA.shared.applicationWillEnterForeground(application)
//        notifyvisitors.applicationWillEnterForeground(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        NVECTA.shared.applicationDidBecomeActive(application)
//        notifyvisitors.applicationDidBecomeActive(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        NVECTA.shared.applicationWillTerminate(application)
//        notifyvisitors.applicationWillTerminate()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NVECTA.shared.application(app, open: url, options: options)
        return true
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


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        NVECTA.shared.willPresent(notification, completion: completionHandler)
//        notifyvisitors.willPresent(notification, withCompletionHandler: completionHandler)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NVECTA.shared.didReceiveRemoteNotification(userInfo, fetchCompletionHandler: completionHandler)
//        notifyvisitors.didReceiveRemoteNotification(userInfo, fetchCompletionHandler: completionHandler)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        NVECTA.shared.handleNotificationResponse(response, autoRedirect: true) { (pushResponse: NotificationClickResponse?) in
            print("handleNotificationResponse = \(String(describing: pushResponse))")
        }
        
//        notifyvisitors.pushNotificationActionData(from: response, autoRedirectOtherApps: true) { (nvPushActionData: NSMutableDictionary?) in
//            print("nv Push Notification ActionData = \(nvPushActionData ?? [:])")
//        }
    }
}
