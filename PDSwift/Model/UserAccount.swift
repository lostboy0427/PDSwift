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
class UserAccount: NSObject, NSCoding{
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
    
    class func requestAccessToken(params:[String : String], completion:@escaping (_ userAccount: UserAccount?, _ error : Error?)->()){
        let url = URL(string: Weibo_AccessToken_Url)!
        request(url, method: .post, parameters: params).responseJSON { (result) in
            
            if(result.error != nil && result.value as? [String : AnyObject] == nil){
                completion(nil,result.error)
                return
            }
            
            if (result.value as? [String : AnyObject] != nil){
                let account = UserAccount(dic:result.value as! [String : AnyObject])
                account.loadUserInfo(completion: completion)
                
            }else{
                let jsonError = NSError(domain: "UserAccount", code: -100, userInfo: ["error":"you are too hansome to hold"])
                completion(nil, jsonError)
            }
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
    
    func loadUserInfo(completion:@escaping (_ userAccount: UserAccount?, _ error : Error?)->()) {
        let params = ["access_token":self.access_token,"uid":self.uid]
        let url = URL(string: Weibo_UserInfo_Url)!
        request(url, method: .get, parameters: params).responseJSON { (responseData) in
            let resultDic = responseData.value as?[String : AnyObject]
            if(responseData.error != nil && resultDic == nil){
                completion(nil,responseData.error)
                return
            }
            self.avatar_large = resultDic?["avatar_large"]as? String
            self.name = resultDic?["name"] as? String
            NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.accountPath)
            completion(self,nil)
        }
    }
    
    
    // delegate
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
    
    //    override var description: String {
    //        let properties = ["access_token", "expires_in", "uid", "expiresDate"]
    //        return "\(dictionaryWithValues(forKeys:properties))"
    //    }
}
