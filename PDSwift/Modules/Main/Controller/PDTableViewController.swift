//
//  PDTableViewController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/20/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class PDTableViewController: UITableViewController,PDSignInViewDelegate {
    var visitorLogInView: PDSignInView?
    override func loadView() {
        if PDUserAccount != nil {
            super.loadView()
            return
        }
        visitorLogInView = (Bundle.main.loadNibNamed("PDSignInView", owner: nil, options: nil)?.last as! PDSignInView)
        visitorLogInView?.delegate = self
        view = visitorLogInView
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(PDSignInViewRegisterDidClick))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(PDSignInViewLogInDidClick))
    }
    
    @objc func PDSignInViewRegisterDidClick() {
        print("register")
    }
    
    @objc func PDSignInViewLogInDidClick() {
        present(UINavigationController(rootViewController: OAuthViewController()), animated: true, completion: nil)
    }
}

