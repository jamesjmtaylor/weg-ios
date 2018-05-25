//
//  AppDelegate.swift
//  weg-ios
//
//  Created by Taylor, James on 4/23/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().barStyle = .blackOpaque
        FirebaseApp.configure()
        return true
    }
}

