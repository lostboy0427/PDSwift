//
//  PDMainViewController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/11/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit
let HomeCellIdenteifier = "HomeCell"
class PDHomeViewController: PDTableViewController,UIViewControllerTransitioningDelegate {
    var statusArr : [Status]?{
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        
        if PDUserAccount == nil {
            return
        }
        tableView.register(PDHomeCell.classForCoder(), forCellReuseIdentifier: HomeCellIdenteifier)
        Status.loadHomeData { (dataArr) in
            if dataArr != nil {
                self.statusArr = dataArr
                return
            }
            SVProgressHUD.show(withStatus: "数据加载不正确")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let message = "登录后，最新、最热微博尽在掌握，不再与事实擦肩而过"
        visitorLogInView?.setupSubviews(imageName: "visitordiscover_feed_image_house", message: message, isHome: true)
    }
    
    //MARK: - dataSource & delegate(protocol)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusArr?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: HomeCellIdenteifier, for: indexPath)
        cell.textLabel?.text = statusArr![indexPath.row].text
        if let path = statusArr![indexPath.row].thumbnail_pic {
            let url = URL(string: path)
            cell.imageView?.sd_setImage(with: url, completed: nil)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentVc = PopPresentationController(presentedViewController: presented, presenting: presenting)
        return presentVc
    }
    
    //MARK: - UI layout
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIBarButtonItem.barButtonItem(imageName: "navigationbar_friendsearch", selector: #selector(friendsearch)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIBarButtonItem.barButtonItem(imageName: "navigationbar_pop", selector: #selector(qr_scan)))
        navigationItem.titleView = self.titleBtn
    }
    //MARK: - public methods
    //MARK: - private methods
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
    
    //MARK: - lazy
    lazy var titleBtn: UIButton = {
        let btn = HomeTitleButton()
        btn.setTitle(PDUserAccount != nil ? PDUserAccount?.name : "首页" , for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        btn.setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        btn .addTarget(self, action: #selector(showExtendView), for: .touchUpInside)
        btn.sizeToFit()
        return btn
    }()
    
}

extension UIBarButtonItem {
   class func barButtonItem(imageName: String, selector: Selector)-> UIView {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        btn.addTarget(self, action: selector, for: .touchUpInside)
        return btn
    }
}
