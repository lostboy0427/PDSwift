//
//  OAuthViewController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/21/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit
class OAuthViewController: UIViewController ,UIWebViewDelegate{
    
    let OAuth_authri_Url = "https://api.weibo.com/oauth2/authorize"
    let Weibo_AppKey = "4214145745"
    let Weibo_AppSecret = "720e0be874ecbb2dbe117ce757d0017e"
    let Weibo_Redirect_Uri = "http://www.baidu.com"
    
    var webView: UIWebView {
        return view as! UIWebView
    }
    
    override func loadView() {
        super.loadView()
        view = UIWebView(frame: view.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItem()
        requestAuthrize()
    }
    
    func setupBarItem() {
        title = "微博OAuth 授权"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
    }
    
    func requestAuthrize() {
        let urlString = OAuth_authri_Url + "?client_id=" + Weibo_AppKey + "&redirect_uri=" + Weibo_Redirect_Uri
        let url = URL(string: urlString)!
        webView.loadRequest(URLRequest.init(url:url))
        webView.delegate = self
        
    }
    
    @objc func close(){
        dismiss(animated: true, completion: nil)
    }
    
    // delegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        let urlString = request.url!.absoluteString
        if urlString.hasPrefix("https://api.weibo.com/") {
            return true
        }
        
        if !urlString.hasPrefix(Weibo_Redirect_Uri) {
            return false
        }
        let code = "code="
        let str = request.url!.query
        if str!.hasPrefix(code){
            let authrizeCode = (str! as NSString) .substring(from: code.lengthOfBytes(using: .utf8))
            requestAccessToken(code: authrizeCode)
        }else{
            SVProgressHUD.dismiss()
            dismiss(animated: true, completion: nil)
        }
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func requestAccessToken(code: String) {
        let params = ["client_id":Weibo_AppKey,
                      "client_secret":Weibo_AppSecret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":Weibo_Redirect_Uri]
        UserAccount.requestAccessToken(params: params) { (userAccount, error) in
            if(error == nil && userAccount != nil){
                PDUserAccount = userAccount
                let welcomeVc = UIStoryboard(name: "WelcomViewController", bundle: nil).instantiateInitialViewController() as! WelcomViewController
                self.present(welcomeVc, animated: false, completion: nil)
                return
            }
            SVProgressHUD.showInfo(withStatus: error.debugDescription)
            return
        }
    }
}
