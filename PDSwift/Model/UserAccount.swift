//
//  UserAccount.swift
//  PDSwift
//
//  Created by 肖培德 on 11/21/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit
let Weibo_AccessToken_Url = "https://api.weibo.com/oauth2/access_token"
let Weibo_UserInfo_Url = "https://api.weibo.com/2/users/show.json"
//用于用户登录
@objcMembers class UserAccount: NSObject, NSCoding{
    let access_token : String
    let expires_in :TimeInterval
    let expiresDate: NSDate
    let uid : String
    var avatar_large : String?
    var name: String?
    static let accountPath = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")
    
    
    init(dic:[String : AnyObject]) {
        access_token = dic["access_token"] as! String
        expires_in = dic["expires_in"] as! TimeInterval
        expiresDate = NSDate(timeIntervalSinceNow: expires_in)
        uid = dic["uid"] as! String
    }

    //MARK: - Xib
    
    //MARK: - protocol
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
        aCoder.encode(expiresDate, forKey: "expiresDate")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(avatar_large, forKey:"avatar_large")
        aCoder.encode(name, forKey: "name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as! String
        expires_in = aDecoder.decodeDouble(forKey: "expires_in") as TimeInterval
        expiresDate = aDecoder.decodeObject(forKey: "expiresDate") as! NSDate
        uid = aDecoder.decodeObject(forKey: "uid") as! String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
    }
    //MARK: - UI layout
    
    //MARK: - private methods
    class func requestAccessToken(params:[String : String], completion:@escaping (_ userAccount: UserAccount?)->()){
        
        NetworkTool.requestJSON(Weibo_AccessToken_Url, method: .post, parameters: params as [String : AnyObject]) { (responseObject) in
            if responseObject == nil {return}
            let account = UserAccount(dic: responseObject as! [String : AnyObject])
            account.loadUserInfo(completion: completion)
        }
    }
    
    class func UnArchiverData()-> UserAccount?{
        
        if let userAccount = NSKeyedUnarchiver.unarchiveObject(withFile: UserAccount.accountPath)as? UserAccount {
            
            if userAccount.expiresDate.compare(Date()) == ComparisonResult.orderedDescending {
                return userAccount
            }
        }
        return nil
    }
    
    func loadUserInfo(completion:@escaping (_ userAccount: UserAccount?)->()) {
        let params = ["access_token":self.access_token,"uid":self.uid]
        
        NetworkTool.requestJSON(Weibo_UserInfo_Url, method: .get, parameters: params as [String : AnyObject]) { (responseObject) in
            if responseObject == nil {return}
            
            self.avatar_large = (responseObject as! NSDictionary)["avatar_large"]as? String
            self.name = (responseObject as! NSDictionary)["name"] as? String
            NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.accountPath)
            completion(self)
        }
    }
    
    //MARK: - description
    override var description: String {
        let properties = ["access_token", "expires_in", "uid", "expiresDate"]
        return "\(dictionaryWithValues(forKeys:properties))"
    }
}
