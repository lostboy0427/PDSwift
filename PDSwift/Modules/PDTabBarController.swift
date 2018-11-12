//
//  PDTabBarController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/11/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class PDTabBarController: BaseTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configSubviews()
        selectedIndex = 1
        
    }
    
    func configSubviews() {
        let nv1 = self.setupNavigationVC(vc: PDMainViewController(), title: "首页", imageName: "applyWithdraw")
        let nv2 = self.setupNavigationVC(vc: PDAboutViewController(), title: "关于", imageName: "warrantyGold")
        let nv3 = self.setupNavigationVC(vc: PDMineViewController(), title: "我的", imageName: "more_personal")
        self.setViewControllers([nv1,nv2,nv3], animated: true)
    }
    
    func setupNavigationVC(vc: UIViewController, title:String, imageName: String) -> UINavigationController {
        vc.tabBarItem = UITabBarItem.tabBarItem(Title: title, TitleSize: UIFont.systemFont(ofSize: 14), TitleColor: UIColor.lightGray, SelectedTitleColor: UIColor.gray, ImageName: imageName, SelectedImageName: nil)
        let naviVC = PDNavigationController(rootViewController: vc)
        return naviVC
    }
}

extension UITabBarItem {
   static func tabBarItem(Title title: String, TitleSize titleSize:UIFont, TitleColor titleColor: UIColor , SelectedTitleColor selectedTitleColor:UIColor, ImageName imageName:String, SelectedImageName selectedImageName:String?)-> UITabBarItem {
    let tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName ?? "6"))
    
    tabBarItem.setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key: UIColor.lightGray, kCTFontSizeAttribute as NSAttributedString.Key:titleSize], for: .normal)
    tabBarItem.setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key: UIColor.gray, kCTFontSizeAttribute as NSAttributedString.Key:titleSize], for: .selected)
    return tabBarItem
    }
}
