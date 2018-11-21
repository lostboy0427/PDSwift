//
//  PDAboutViewController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/11/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class PDDiscoverViewController: PDTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let message = "登录后，最新、最热微博尽在掌握，不再与事实擦肩而过"
        visitorLogInView?.setupSubviews(imageName: "visitordiscover_image_message", message: message, isHome: false)
    }
}
