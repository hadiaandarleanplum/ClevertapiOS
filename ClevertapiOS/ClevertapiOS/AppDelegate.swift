//
//  AppDelegate.swift
//  ClevertapiOS
//
//  Created by Hadia Andar on 7/18/22.
//

import UIKit
import CleverTapSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CleverTap.autoIntegrate()
        UIApplication.shared.registerForRemoteNotifications()
        registerForPushNotifications()
        return true
    }
    
    //ask for push auth from user
    func registerForPushNotifications() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) {
                (granted, error) in
                if (granted) {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
    
    //set device token
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        CleverTap.sharedInstance()?.setPushToken(deviceToken as Data)
    }
    
    //check if device is registered for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            NSLog("%@: failed to register for remote notifications: %@", self.description, error.localizedDescription)
        }
        
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            NSLog("%@: registered for remote notifications: %@", self.description, deviceToken.description)
        }
    
    //track notification opens and fire attached deep links
//    /** For iOS 10 and above - Background **/
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                    didReceive response: UNNotificationResponse,
//                                    withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        /**
//         Use this method to perform the tasks associated with your app’s custom actions. When the user responds to a notification, the system calls this method with the results. You use this method to perform the task associated with that action, if at all. At the end of your implementation, you must call the completionHandler block to let the system know that you are done processing the notification.
//
//         You specify your app’s notification types and custom actions using UNNotificationCategory and UNNotificationAction objects. You create these objects at initialization time and register them with the user notification center. Even if you register custom actions, the action in the response parameter might indicate that the user dismissed the notification without performing any of your actions.
//
//         If you do not implement this method, your app never responds to custom actions.
//
//         see https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter
//
//         **/
//
//        // if you wish CleverTap to record the notification open and fire any deep links contained in the payload. Skip this line if you have opted for auto-integrate.
//        CleverTap.sharedInstance()?.handleNotification(withData: response.notification.request.content.userInfo)
//
//        completionHandler()
//
//    }
//
//    /** For iOS 10 and above - Foreground**/
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
//
//           /**
//         Use this method to perform the tasks associated with your app's custom actions. When the user responds to a notification, the system calls this method with the results. You use this method to perform the task associated with that action, if at all. At the end of your implementation, you must call the completionHandler block to let the system know that you are done processing the notification.
//
//         You specify your app's notification types and custom actions using UNNotificationCategory and UNNotificationAction objects.
//         You create these objects at initialization time and register them with the user notification center. Even if you register custom actions, the action in the response parameter might indicate that the user dismissed the notification without performing any of your actions.
//
//         If you do not implement this method, your app never responds to custom actions.
//
//         see https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter
//         **/
//
//        print("APPDELEGATE: didReceiveResponseWithCompletionHandler \(response.notification.request.content.userInfo)")
//
//        // If you wish CleverTap to record the notification click and fire any deep links contained in the payload.
//
//         CleverTap.sharedInstance()?.handleNotification(withData: notification.request.content.userInfo, openDeepLinksInForeground: true)
//         completionHandler([.badge, .sound, .alert])
//    }
    
    //push notification callback
    func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
          print("Push Notification Tapped with Custom Extras: \(customExtras)")
          
    }
    
    //push impressions
//    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
//            // While running the Application add CleverTap Account ID and Account token in your .plist file
//            
//            // call to record the Notification viewed
//            CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: request.content.userInfo)
//            super.didReceive(request, withContentHandler: contentHandler)
//        }

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

