//
//  Status.swift
//  PDSwift
//
//  Created by 肖培德 on 11/24/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit
private let Weibo_Home_Timeline_Url = "https://api.weibo.com/2/statuses/home_timeline.json"
@objcMembers class Status: NSObject {
    
    var created_at : String?
    var id : Int? = 0
    var text: String?
    var source : String?
    var pic_urls: [[String : String]]?
    var thumbnail_pic: String?
    var original_pic: String?
    var user: User?
    
    //字典转模型
    init(dict:[String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String){  }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "user" {
            user = User(dict: value as! [String : AnyObject])
        }else{
             super.setValue(value, forKey: key)
        }
    }

    //MARK: - private methods
    class func loadHomeData(_ completion:@escaping (_ statusResult:[Status]?)->()) {
        
        let parameter = ["access_token":PDUserAccount!.access_token]
        
        NetworkTool.requestJSON(Weibo_Home_Timeline_Url, method: .get, parameters: parameter as [String : AnyObject]) { (responseObject) in
            if responseObject == nil {return}
            if let dict = (responseObject as! NSDictionary)["statuses"] as? [[String : AnyObject]] {
                completion(getUserStatus(status: dict))
            }else{//  value for key "statuses" 不是字典
                completion(nil)
            }
        }
    }
    
    class func getUserStatus(status:[[String : AnyObject]])-> [Status]? {
        var temArr = [Status]()
        for item in status {
            let status = Status(dict: item)
            temArr.append(status)
        }
        return temArr
    }
    //MARK: - lazy
   
}
