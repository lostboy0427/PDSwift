//
//  PDSignInView.swift
//  PDSwift
//
//  Created by 肖培德 on 11/20/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

protocol PDSignInViewDelegate:NSObjectProtocol {
    func PDSignInViewRegisterDidClick()
    func PDSignInViewLogInDidClick()
}

class PDSignInView: UIView {

    @IBOutlet weak var bigBackImage: UIImageView!
    @IBOutlet weak var smallBackImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    weak var delegate : PDSignInViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    @IBAction func register(_ sender: Any) {
        delegate?.PDSignInViewRegisterDidClick()
    }
    
    @IBAction func login(_ sender: Any) {
        delegate?.PDSignInViewLogInDidClick()
    }

    func setupSubviews(imageName:String, message:String, isHome: Bool) {
        if isHome {
            smallBackImage.image = UIImage(named: imageName)
            startAnimation()
        }else{
            bigBackImage.image = UIImage(named: imageName)
        }
        smallBackImage.isHidden = !isHome
        title.text = message
    }
    
    func startAnimation() {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.byValue = Double.pi * 2
        animation.duration = 20
        animation.repeatCount = MAXFLOAT
        bigBackImage.layer.add(animation, forKey: nil)
    }
    
    func stopAnimation() {
        bigBackImage.layer.removeAllAnimations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
