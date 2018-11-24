//
//  HomeTitleButton.swift
//  PDSwift
//
//  Created by 肖培德 on 11/23/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class HomeTitleButton: UIButton {

    var marge = 5.0
    override func layoutSubviews() {
        super.layoutSubviews()
        let titleW = self.titleLabel?.bounds.width
        let imageW = self.imageView?.bounds.width
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (titleW! + CGFloat(marge)), bottom: 0, right: -titleW!)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageW!, bottom: 0, right:imageW!)
    }
}
