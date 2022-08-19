//
//  ViewController.swift
//  ClevertapiOS
//
//  Created by Hadia Andar on 7/18/22.
//

import UIKit
import CleverTapSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let profile = [
            //Update pre-defined profile properties
            "Name": "Apple Montana",
            "Email": "Apple.montana@gmail.com",
            //Update custom profile properties
            "Plan type": "Silver",
            "Favorite Food": "Pizza"
        ]

        CleverTap.sharedInstance()?.onUserLogin(profile)
        
        CleverTap.sharedInstance()?.recordEvent("User Logged In");
    }


}

