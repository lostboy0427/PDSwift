//
//  PDMainViewController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/11/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class PDMainViewController: PDTableViewController,UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let message = "登录后，最新、最热微博尽在掌握，不再与事实擦肩而过"
        visitorLogInView?.setupSubviews(imageName: "visitordiscover_feed_image_house", message: message, isHome: true)
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barButtonItem(imageName: "navigationbar_friendsearch", selector: #selector(friendsearch)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButtonItem(imageName: "navigationbar_pop", selector: #selector(qr_scan)))
        navigationItem.titleView = self.titleBtn
    }
    
    func barButtonItem(imageName: String, selector: Selector)-> UIView {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
    
    //delegate
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentVc = PopPresentationController(presentedViewController: presented, presenting: presenting)
        return presentVc
    }
    
    @objc func friendsearch(){
        
    }
    @objc func qr_scan(){
        
    }
    
    @objc func showExtendView(){
        
        let holderVc = PDHolderViewController()
        holderVc.transitioningDelegate = self
        holderVc.modalPresentationStyle = UIModalPresentationStyle.custom
        present(holderVc, animated: true, completion: nil)
    }
    
    lazy var titleBtn: UIButton = {
        let btn = HomeTitleButton()
        btn.setTitle(hasLoggedIn ? PDUserAccount?.name : "首页" , for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        btn.setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        btn .addTarget(self, action: #selector(showExtendView), for: .touchUpInside)
        btn.sizeToFit()
        return btn
    }()
    
}
