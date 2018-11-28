//
//  PhotoViewerController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/27/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class PhotoViewerController: UIViewController {

    var imageView: UIImageView? = UIImageView()
    var dismissClosuer:(()->())?
    var imageUrl: URL? {
        didSet{
            imageView?.sd_setImage(with: imageUrl, placeholderImage: nil, options: SDWebImageOptions.continueInBackground, completed: { (image, _, _, _) in
                
                self.imageView?.sizeToFit()
//                self.imageView?.frame = CGRect(origin: CGPoint.zero, size: self.imageSize(image: image!))
//                self.imageView?.center = self.view.center
//                print("imageViewFrame:\(String(describing: self.imageView?.frame))")
            })
        }
    }
    
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.addSubview(imageView!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        imageView?.center = view.center
//        view.addSubview(imageView!)
    }
    
    func imageSize(image : UIImage)-> CGSize {
        let imageW = image.size.width
        let imageH = image.size.height
        
        let scale = imageW/imageH
        let scaleX = imageW/ScreenWith
        let scaleY = imageH/ScreenHeight
        
        if imageW > ScreenWith && imageH > ScreenHeight {
            if scaleX >= scaleY {
                return CGSize(width: ScreenWith, height: ScreenWith / scale)
            }else{
                return CGSize(width: ScreenHeight * scale, height: ScreenHeight)
            }
        }
        if imageW >= ScreenWith && imageH <= ScreenHeight {
            return CGSize(width: ScreenWith, height: ScreenWith / scale)
        }else if(imageW <= ScreenWith && imageH > ScreenHeight){
            return CGSize(width: ScreenHeight * scale, height: ScreenHeight)
        }
        return CGSize.zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissClosuer!()
    }
}
