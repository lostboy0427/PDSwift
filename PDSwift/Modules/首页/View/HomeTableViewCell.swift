//
//  HomeTableViewCell.swift
//  PDSwift
//
//  Created by 肖培德 on 11/25/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var verifiedImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var vipLevelImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionviewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    ///转发区域
    @IBOutlet weak var retweetView: UIView!
    @IBOutlet weak var retweetContentLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    var status:Status?{
        didSet{
            iconImage.sd_setImage(with: URL(string: (status?.user?.profile_image_url)!), completed: nil)
            verifiedImage.image = status?.user?.verifiedImage
            nameLable.text = status?.user?.name
            let vipName = "common_icon_membership_level" + "\(status?.user?.verified_level ?? 0)"
            let image = UIImage(named: vipName)
            vipLevelImage.image = image
            sourceLabel.text = status?.source
            contentLabel.text = status?.text
            collectionviewWidthConstraint.constant = calcutaleCollectionViewSize().viewSize.width
            collectionViewHeightConstraint.constant = calcutaleCollectionViewSize().viewSize.height
            collectionViewLayout.itemSize = calcutaleCollectionViewSize().itemSize
            retweetContentLabel?.text = (status?.retweeted_status?.user?.name ?? "") + ":" + (status?.retweeted_status?.text ?? "")
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        nameLable.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func calcutaleCollectionViewSize() -> (viewSize:CGSize,itemSize:CGSize){
        let imageCount = status?.pictureUrls?.count
        let itemWith: CGFloat = 90
        let interval: CGFloat = 10
        let itemSize = CGSize(width: itemWith, height: itemWith)
        let column = 3
        switch imageCount {
        case 0:
            return (CGSize.zero , itemSize)
        case 1://1张图片 显示原尺寸
            //           let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: key!)

//            let key = status?.imageUrls?.first?.absoluteString
//            let url = URL(string: key!)
            
//            print("单张图片\(key!)")
           return (itemSize,itemSize)
            
        case 4://4张图片 两行两列 固定尺寸
            return (CGSize(width: itemWith * 2 + interval, height: itemWith * 2 + interval),itemSize)
            
        default:   //其他    三列 固定尺寸
            let index = CGFloat ((imageCount! - 1)/column + 1)
            return (CGSize(width: itemWith * 3 + interval * 2, height: itemWith * index + interval * (index - 1)),itemSize)
        }
    }
    
    func rowHeight(status: Status) -> CGFloat{
        //赋值微博数据
        self.status = status
        // 刷新页面
        layoutIfNeeded()
        return bottomView.frame.maxY
    }
    
    class  func cellIdentifer(status: Status)-> String {
        if status.retweeted_status != nil {
            return "HomeRetweetCell"
        }else{
            return "HomeTableViewCell"
        }
    }
}

extension HomeTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.pictureUrls?.count ?? 0
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePictureCell", for: indexPath) as! HomePictureCell
        cell.imageUrl = status?.pictureUrls![indexPath.item]
        return cell
    }
}


class HomePictureCell: UICollectionViewCell {

    @IBOutlet weak var imageVIew: UIImageView!
    var imageUrl:URL?{
        didSet{
        print(imageUrl as Any)
        imageVIew.sd_setImage(with: imageUrl, completed: nil)
        }
    }
}
