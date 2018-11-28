//
//  HomePhotoBrowerViewController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/27/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit
let HomePhotoBrowerIdentifier = "HomePhotoBrowerCell"
class HomePhotoBrowerViewController: UIViewController {
    
    var imageUrls:[URL]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView!)
        collectionView?.register(HomePhotoBrowerCell.classForCoder(), forCellWithReuseIdentifier: HomePhotoBrowerIdentifier)
    }
    
    
    lazy var layout:UICollectionViewFlowLayout? = {
       let l = UICollectionViewFlowLayout.init()
        l.itemSize = CGSize(width: ScreenWith, height: ScreenHeight)
        l.minimumLineSpacing = 0
        l.minimumInteritemSpacing = 0
        l.scrollDirection = .horizontal
        return l
    }()
    
    lazy var collectionView:UICollectionView? = {
        let collection = UICollectionView.init(frame:UIScreen.main.bounds, collectionViewLayout: layout!)
        collection.dataSource = self
        collection.isPagingEnabled = true
        return collection
    }()
  
}

extension HomePhotoBrowerViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePhotoBrowerIdentifier, for: indexPath) as! HomePhotoBrowerCell
//        cell.imageUrl = imageUrls![indexPath.item]
//        cell.dismissClosure = {
//            self.dismiss(animated: false, completion: nil)
//        }
//        //添加子控制器
//        if !children.contains(cell.viewerVc!){
//           addChild(cell.viewerVc!)
//        }
//
        cell.backgroundColor = UIColor(red: randomColor(), green: randomColor(), blue: randomColor(), alpha: 1)
        return cell
    }
    
    func randomColor()->CGFloat {
        return CGFloat(arc4random_uniform(265))/255
    }
}



class HomePhotoBrowerCell: UICollectionViewCell {
    var dismissClosure:(()->())?
    var imageUrl : URL?{
        didSet{
            viewerVc?.imageUrl = imageUrl
        }
    }
    
    var viewerVc: PhotoViewerController?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        viewerVc = PhotoViewerController()
        viewerVc!.view.frame = frame
        viewerVc?.dismissClosuer = {
            self.dismissClosure!()
        }
//        contentView.addSubview(viewerVc!.view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
