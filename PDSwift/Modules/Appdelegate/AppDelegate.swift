//
//  AppDelegate.swift
//  PDSwift
//
//  Created by 肖培德 on 11/11/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit
var PDUserAccount = UserAccount.UnArchiverData()
let WeiBo_LogIn_Success_Notification = "WeiBo_LogIn_Success_Notification"
private let Weibo_note = "You haven't signed in!"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().tintColor = UIColor.orange
        window = UIWindow.init(frame: UIScreen.main.bounds)
        showMainInterface()
        window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showTabBarMainVc), name: NSNotification.Name(rawValue: WeiBo_LogIn_Success_Notification), object: nil)
        return true
    }
    
    func showMainInterface() {
        if PDUserAccount != nil {
            let SBName = isUpdatedVersion() ? "PDNewFeatureController" : "WelcomViewController"
            showStoryboardViewController(name: SBName)
            return
        }
        showTabBarMainVc()
        print(isUpdatedVersion())
    }
    
    @objc func showTabBarMainVc() {
        window?.rootViewController = PDTabBarController()
    }
    //查看是刚更新版本
    func isUpdatedVersion()-> Bool {
        let currentVersionStr = Bundle.main.infoDictionary?["CFBundleInfoDictionaryVersion"] as! String
        let currentVersion = NumberFormatter().number(from: currentVersionStr)
        
        //取储存的
        let versionKey = "versionKey"
        let userDefault = UserDefaults.standard
        let oldVersion = userDefault.double(forKey: versionKey)
        userDefault .set(currentVersion?.doubleValue, forKey: versionKey)
        return (currentVersion?.doubleValue)! > oldVersion
    }
    
    private func showStoryboardViewController(name: String) {
        let vc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()
        window?.rootViewController = vc
    }
}

