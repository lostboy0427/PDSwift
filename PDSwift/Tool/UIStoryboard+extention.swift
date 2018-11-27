//
//  UIStoryboard+extention.swift
//  PDSwift
//
//  Created by 肖培德 on 11/26/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

extension  UIStoryboard {
    
  class func viewControllerWithStoryboard(name: String?)-> UIViewController {
    let vc = UIStoryboard(name: name!, bundle: nil).instantiateInitialViewController()!
        return vc
    }
}
