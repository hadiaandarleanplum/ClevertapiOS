//
//  ViewController.swift
//  ClevertapiOS
//
//  Created by Hadia Andar on 7/18/22.
//

import UIKit
import CleverTapSDK

class ViewController: UIViewController, CleverTapDisplayUnitDelegate, CleverTapPushPermissionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        
        CleverTap.sharedInstance()?.setDisplayUnitDelegate(self)
        
        let profile = [
            //Update pre-defined profile properties
            "Name": "Apple Montana2",
            "Email": "Apple.montana2@gmail.com",
            "Identity": 71026033,
            "Phone": "+14155551234",      // Phone (with the country code, starting with +)
            //Update custom profile properties
            "Plan type": "Silver",
            "Favorite Food": "Pizza",
            "App install": "Jan 17 2023"
        ] as [String : Any]
        
        /*let profile = [
            //Update pre-defined profile properties
            "Name": "Washos Test 3",
            "Email": "washos3@gmail.com",
            "Identity": 1189549,
            "Phone": "+16155451232",      // Phone (with the country code, starting with +)
            //Update custom profile properties
            "Plan type": "Silver",
            "Favorite Food": "Pizza",
            "App install": "Jan 18 2023"
        ] as [String : Any]*/

        CleverTap.sharedInstance()?.onUserLogin(profile)
        CleverTap.sharedInstance()?.setPushPermissionDelegate(self)
        
        CleverTap.sharedInstance()?.recordEvent("User Logged In");
        
        // event with properties
        let props = [
            "Product name": "Casio Chronograph Watch",
            "Category": "Mens Accessories",
            "Price": 59.99,
            "Date": NSDate()
        ] as [String : Any]

        CleverTap.sharedInstance()?.recordEvent("Product viewed", withProps: props)
    }
    
    func displayUnitsUpdated(_ displayUnits: [CleverTapDisplayUnit]) {
           // you will get display units here
        var units:[CleverTapDisplayUnit] = displayUnits;
    }
    
    
    
    /** For iOS 10 and above - Foreground**/

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {

           /**
         Use this method to perform the tasks associated with your app's custom actions. When the user responds to a notification, the system calls this method with the results. You use this method to perform the task associated with that action, if at all. At the end of your implementation, you must call the completionHandler block to let the system know that you are done processing the notification.
         
         You specify your app's notification types and custom actions using UNNotificationCategory and UNNotificationAction objects.
         You create these objects at initialization time and register them with the user notification center. Even if you register custom actions, the action in the response parameter might indicate that the user dismissed the notification without performing any of your actions.
         
         If you do not implement this method, your app never responds to custom actions.
         
         see https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate/1649501-usernotificationcenter
         **/


        // If you wish CleverTap to record the notification click and fire any deep links contained in the payload.
      

    }
    
    
    
    
}

