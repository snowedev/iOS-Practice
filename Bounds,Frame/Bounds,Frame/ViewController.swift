//
//  ViewController.swift
//  Bounds,Frame
//
//  Created by 이원석 on 2021/03/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var superView: UIView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var subSubView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subView.bounds.origin.x = 200

        subView.bounds.origin.y = 100
//        print("subView(skyblue)'s frame: ",subView.frame.origin.x,subView.frame.origin.y)
//        print("subSubView(purple)'s frame: ",subSubView.frame.origin.x,subSubView.frame.origin.y)
        print("subView(skyblue)'s bounds: ",subView.bounds.origin.x,subView.bounds.origin.y)
        print("subSubView(purple)'s bounds: ",subSubView.bounds.origin.x,subSubView.bounds.origin.y)
    }
    
    
}

