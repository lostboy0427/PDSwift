//
//  User.swift
//  PDSwift
//
//  Created by 肖培德 on 11/25/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

@objcMembers class User: NSObject {

    var id : Int? = 0
    var name: String?
    var profile_image_url:String?
    // 认证类型 -1：没有认证，0，认证用户，2,3,5: 企业认证，220: 草根明星（达人）
    var verified_type: Int? = -1
    
    var verifiedImage:UIImage?{
        switch verified_type {
        case 0: //未认证
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return UIImage(named: "avatar_vip")
        }
    }
    
    var avatar_large: String?
    // 1～6 一共6级会员
    var verified_level:Int? = 0
        
    var mbrank: Int = 0
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
}
