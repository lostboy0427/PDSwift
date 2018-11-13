//
//  PDMainViewController.swift
//  PDSwift
//
//  Created by 肖培德 on 11/11/18.
//  Copyright © 2018 肖培德. All rights reserved.
//

import UIKit

class PDMainViewController: BaseViewController {

    func sum(a : Int , b : Int)-> Int {
        return a + b
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        view.backgroundColor = UIColor.orange
        let sumb = {
            print("wriggle inside your hole")
        }
        
        let sumc = {(a:Int,b:Int)->Int in
            return a * b
        }
        sumb()
        print(sumc(4,5))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
