//
//  ViewController.swift
//  Layer
//
//  Created by 이원석 on 2021/04/06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testGreenBox: UIView!{
        didSet{
            testGreenBox.layer.cornerRadius = 50
            testGreenBox.layer.masksToBounds = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

