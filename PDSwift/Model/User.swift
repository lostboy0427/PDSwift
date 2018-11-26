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
    var verified_type: Int? = -1
    var avatar_large: String?
    var verified_level:Int? = 0
    var mbrank: Int = 0
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
}
