//
//  WelcomViewController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/23/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class WelcomViewController: UIViewController {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var welcomeTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let avatar = PDUserAccount?.avatar_large {
            let url = URL(string: avatar)
            iconImage!.sd_setImage(with: url, completed: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animation()
    }
    func animation() {
        bottomConstraint.constant = ScreenHeight - bottomConstraint.constant
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIView.AnimationOptions.layoutSubviews, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 2, animations: {
                self.welcomeTitle.alpha = 1
            }) { _ in
                NotificationCenter.default.post(name:NSNotification.Name(rawValue: WeiBo_LogIn_Success_Notification), object: self, userInfo: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

