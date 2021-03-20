//
//  MainVC.swift
//  NotificationCenter
//
//  Created by 이원석 on 2021/03/20.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func postBtnTapped(_ sender: Any) {
        NotificationCenter.default.post(
                    name: NSNotification.Name(rawValue: "PostButton"),
                    object: nil)
    }
}
