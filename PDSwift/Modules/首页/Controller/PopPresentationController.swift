//
//  PopPresentationController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/23/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class PopPresentationController: UIPresentationController {

    lazy var dummyView:UIView = {
        let subView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss(tap:)))
        subView.addGestureRecognizer(tap)
        subView.backgroundColor = UIColor.init(white:0, alpha: 0.5)
        return subView
    }()
    
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView?.frame = CGRect(x: 100, y: 56, width: 200, height: 240)
        self.dummyView.frame = containerView!.bounds
        containerView?.insertSubview(self.dummyView, at: 0)
    }
    
    @objc func dismiss(tap: UITapGestureRecognizer) {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}
