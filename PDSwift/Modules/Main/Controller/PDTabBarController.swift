//
//  PDTabBarController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/11/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

let ScreenWith = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height
var isLogIn : Bool = false

class PDTabBarController: BaseTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = PDTabBar()
        tabBar.composeBtn .addTarget(self, action: #selector(composeContent), for: .touchUpInside)
        setValue(tabBar, forKey: "tabBar")
        configSubviews()
    }
    
    func configSubviews() {
        addChildVC(PDMainViewController(),"首页","tabbar_home")
        addChildVC(PDMessageViewController(),"信息", "tabbar_message_center")
        addChildVC(PDDiscoverViewController(),"发现","tabbar_discover")
        addChildVC(PDMineViewController(),"我的","tabbar_profile")
    }
    
    func addChildVC(_ vc: UIViewController,_ title:String,_ imageName: String){
        let naviVC = PDNavigationController(rootViewController: vc)
        tabBar.tintColor = UIColor.orange
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        addChild(naviVC)
    }
    
   @objc func composeContent() {
        print("发表文章")
    }
}
