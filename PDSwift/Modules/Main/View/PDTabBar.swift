//
//  PDTabBar.swift
//  PDSwift
//
//  Created by 肖培德 on 11/13/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class PDTabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        let num:CGFloat = 5
        let width = ScreenWith/num
        let height = self.bounds.height
        var i = 0
        for view in subviews {
            if view is UIControl && !(view is UIButton){
                view.frame = CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height)
                i += 1
                if i == 2{
                    i += 1
                }
            }
        }
        self.composeBtn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        self.composeBtn.center = CGPoint(x:ScreenWith/2, y: height/2)
    }
    
    lazy var composeBtn : UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)

        btn.setImage(UIImage(named: "tabbar_compose_icon_add_hightlighed"), for: .selected)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighed"), for: .selected)
        self.addSubview(btn)
        return btn
    }()
}
