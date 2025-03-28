//
//  AppDelegate.swift
//  ClevertapiOS
//
//  Created by Hadia Andar on 7/18/22.
//

import UIKit
import CleverTapSDK
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // CleverTap integration
        CleverTap.autoIntegrate()
        
        // Set delegate for push notifications
        UNUserNotificationCenter.current().delegate = self

        // Request push notification permissions
        registerForPushNotifications()
        
        // CleverTap prompt for push permission
        CleverTap.sharedInstance()?.prompt(forPushPermission: true)

        return true
    }
    
    // Request push notification permissions and update CleverTap profile
    func registerForPushNotifications() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            DispatchQueue.main.async {
                center.getNotificationSettings { settings in
                    DispatchQueue.main.async {
                        if settings.authorizationStatus == .authorized {
                            UIApplication.shared.registerForRemoteNotifications()
                            NSLog("SUBSCRIBED FOR PUSH")
                            
                            // Update CleverTap profile - Push is enabled
                            let profile: Dictionary<String, AnyObject> = [
                                "MSG-push": true as AnyObject
                            ]
                            CleverTap.sharedInstance()?.profilePush(profile)
                        } else {
                            NSLog("UNSUBSCRIBED FROM PUSH")
                            
                            // Update CleverTap profile - Push is disabled
                            let profile: Dictionary<String, AnyObject> = [
                                "MSG-push": false as AnyObject
                            ]
                            CleverTap.sharedInstance()?.profilePush(profile)
                        }
                    }
                }
            }
        }
    }

    // Set device token for push notifications
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NSLog("Registered for remote notifications: %@", deviceToken.description)
        CleverTap.sharedInstance()?.setPushToken(deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("Failed to register for remote notifications: %@", error.localizedDescription)
    }
        
    // Handle push notification tap event
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        NSLog("Did receive notification response: %@", response.notification.request.content.userInfo)
        completionHandler()
    }
        
    // Handle push notifications while app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        NSLog("Will present notification: %@", notification.request.content.userInfo)
        
        // Record notification event for CleverTap
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: notification.request.content.userInfo)
        
        // Handle notification for CleverTap
        CleverTap.sharedInstance()?.handleNotification(withData: notification.request.content.userInfo, openDeepLinksInForeground: true)
        
        completionHandler([.badge, .sound, .list, .banner])
    }
        
    // Handle background push notifications
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NSLog("Did receive remote notification: %@", userInfo)
        completionHandler(.noData)
    }
        
    func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
        NSLog("Push notification tapped: customExtras: %@", customExtras)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

}
