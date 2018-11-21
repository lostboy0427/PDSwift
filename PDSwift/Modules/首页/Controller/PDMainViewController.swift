//
//  PDMainViewController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/11/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class PDMainViewController: PDTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let message = "登录后，最新、最热微博尽在掌握，不再与事实擦肩而过"
        visitorLogInView?.setupSubviews(imageName: "visitordiscover_feed_image_house", message: message, isHome: true)
    }
}
