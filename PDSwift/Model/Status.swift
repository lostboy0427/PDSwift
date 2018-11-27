//
//  Status.swift
//  PDSwift
//
//  Created by 肖培德 on 11/24/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit
//private let Weibo_Home_Timeline_Url = "https://api.weibo.com/2/statuses/user_timeline.json"
private let Weibo_Home_Timeline_Url = "https://api.weibo.com/2/statuses/home_timeline.json"
@objcMembers class Status: NSObject {
    
    var created_at : String?
    var id : Int? = 0
    var text: String?
    var source : String?
    var pic_urls: [[String : String]]?{
        didSet{
            imageUrls = [URL]()
                for item in pic_urls! {
                    let url = URL(string: item["thumbnail_pic"]!)
                    imageUrls?.append(url!)
                }
        }
    }
    var pictureUrls:[URL]?{
        if retweeted_status != nil {
            return retweeted_status?.imageUrls
        }else{
            return imageUrls
        }
        
    }
    var imageUrls:[URL]?
    var thumbnail_pic: String?
    var original_pic: String?
    var user: User?
    
    var retweeted_status:Status?
    //字典转模型
    init(dict:[String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String){  }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "user" {
            user = User(dict: value as! [String : AnyObject])
        }else if key == "retweeted_status"{
            retweeted_status = Status(dict: value as! [String : AnyObject])
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
    //MARK: - private methods
    class func loadHomeData(_ completion:@escaping (_ statusResult:[Status]?)->()) {
        
        let parameter = ["access_token":PDUserAccount!.access_token,"count":"50"]
        
        NetworkTool.requestJSON(Weibo_Home_Timeline_Url, method: .get, parameters: parameter as [String : AnyObject]) { (responseObject) in
            if responseObject == nil {return}
            if let dict = (responseObject as! NSDictionary)["statuses"] as? [[String : AnyObject]] {
                let statusArr = getUserStatus(status: dict) as [Status]?
//                cashImageData(statusArr: statusArr, completion)
                completion(statusArr)
            }else{
                //  value for key "statuses" 不是字典
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
    
    class func cashImageData(statusArr : [Status]?, _ completion:@escaping (_ statusResult:[Status]?)->()) {
        
        if statusArr?.count == 0 {return}
        let queue = DispatchGroup.init()
        
        for statusItem in statusArr! {
            if statusItem.imageUrls?.count == 0 {continue}
            
            for url in statusItem.imageUrls! {
                print("\(url).....")
                queue.enter()

                SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: .continueInBackground, progress: nil, completed: { (_, _, _, _) in
                    print("\(url)下载完成")
                    queue.leave()
                })
            }
        }
        queue.notify(queue: DispatchQueue.main, work: DispatchWorkItem.init(block: {
            print("下载完成-------------")
            completion(statusArr)
        }))
    }
    //MARK: - lazy
    
}
