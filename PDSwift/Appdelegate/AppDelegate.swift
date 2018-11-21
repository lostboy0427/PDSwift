//
//  AppDelegate.swift
//  PDSwift
//
//  Created by 肖培德 on 11/11/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        
//        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//        
        UINavigationBar.appearance().tintColor = UIColor.orange
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = PDTabBarController()
        window?.makeKeyAndVisible()
        return true
    }

//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        let handle  : Blue = FBSDKApplicationDelegate
//            .sharedInstance()?.application(app, open: url, options: options)
//        return handle
//    }
}

