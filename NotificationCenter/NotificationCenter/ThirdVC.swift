//
//  ThirdVC.swift
//  NotificationCenter
//
//  Created by 이원석 on 2021/03/20.
//

import UIKit

class ThirdVC: UIViewController {

    @IBOutlet weak var thirdBox: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                    selector: #selector(changeThirdColor),
                    name: NSNotification.Name(rawValue: "PostButton"),
                    object: nil)
    }
    

    @objc func changeThirdColor(){
        thirdBox.backgroundColor = .green
    }
}
