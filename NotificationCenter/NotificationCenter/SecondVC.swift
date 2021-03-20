//
//  SecondVC.swift
//  NotificationCenter
//
//  Created by 이원석 on 2021/03/20.
//

import UIKit

class SecondVC: UIViewController {

    
    @IBOutlet weak var secondBox: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                    selector: #selector(changeSecondColor),
                    name: NSNotification.Name(rawValue: "PostButton"),
                    object: nil)
    }
    

    @objc func changeSecondColor(){
        secondBox.backgroundColor = .orange
    }

}
