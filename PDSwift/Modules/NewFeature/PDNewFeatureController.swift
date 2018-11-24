//
//  TestCollectionViewController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/23/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

let imageNum = 4
private let cellIdentifier = "PDNewFeatureCell"

class PDNewFeatureController: UICollectionViewController{
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        layout.itemSize = CGSize(width:ScreenWith, height: ScreenHeight)
        layout.minimumLineSpacing = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(PDNewFeatureCell.self, forCellWithReuseIdentifier: cellIdentifier)

    }
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNum
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PDNewFeatureCell
        cell.startBtn?.isHidden = true
        cell.image = UIImage(named: "new_feature_" + String(indexPath.item + 1))
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let index = collectionView.indexPathsForVisibleItems.last
        if index?.item == imageNum - 1 {
            let cell = collectionView.cellForItem(at: index!) as! PDNewFeatureCell
            cell.startAnimation()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = collectionView.indexPathsForVisibleItems.last
        if index?.item == imageNum - 1 {
            let cell = collectionView.cellForItem(at: index!) as! PDNewFeatureCell
            cell.startBtn!.isHidden = true
        }
    }
}



class PDNewFeatureCell: UICollectionViewCell {
   
    var imageView:UIImageView?
    var startBtn :UIButton?
    var image : UIImage?{
        didSet{
            imageView?.image = image
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        startBtn = UIButton()
        startBtn?.setBackgroundImage(UIImage(named: "new_feature_finish_button"), for: .normal)
        startBtn?.setTitle("开始体验", for: .normal)
        startBtn?.setTitleColor(UIColor.white, for: .normal)
        startBtn?.addTarget(self, action: #selector(startTosurf), for: .touchUpInside)
        self.contentView.addSubview(imageView!)
        self.contentView.addSubview(startBtn!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView!.frame = contentView.frame
        startBtn!.frame = CGRect(x: 0, y: 0, width: 105, height: 36)
        startBtn?.center = CGPoint(x: ScreenWith/2, y: ScreenHeight/2 + 200)
    }
    
    func startAnimation() {
        startBtn!.isHidden = false
        startBtn!.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity:5, options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.startBtn!.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (_) in
            
        }
    }
    
   @objc func startTosurf() {
    NotificationCenter.default.post(name:NSNotification.Name(rawValue: WeiBo_LogIn_Success_Notification), object: self, userInfo: nil)
    }
}
