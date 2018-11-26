//
//  NetworkTool.swift
//  PDSwift
//
//  Created by 肖培德 on 11/25/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit
/*
 urlStr: request URLsting
 method: request method
 parameters: request parameters, default is nil
 completion: closure after request
 */
class NetworkTool: NSObject {

    class func requestJSON(_ urlStr: String,
                           method: HTTPMethod,
                           parameters: [String : AnyObject]? = nil,
                           completion:@escaping (_ JSON: AnyObject?)->()){
        let url = URL(string: urlStr)
        
        request(url!, method: method, parameters: parameters).responseJSON { (responseResult) in
            
            if let dict = responseResult.value as? [String : AnyObject] {
                if dict["error"] != nil {
                    SVProgressHUD.showError(withStatus: "请求失败，请稍后再试")
                    completion(nil)
                    return
                }
                completion(responseResult.value as AnyObject)
            }else{ // not dictionary
                completion(nil)
            }
        }
    }
}
