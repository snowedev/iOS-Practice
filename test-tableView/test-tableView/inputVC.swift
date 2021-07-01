//
//  inputVC.swift
//  test-tableView
//
//  Created by Wonseok Lee on 2021/06/30.
//

import UIKit

class inputVC: UIViewController {
    
    @IBOutlet weak var textFeild: UITextField!
    @IBOutlet weak var submitBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        MainData.sharedInstance.append(Test(content: textFeild.text!))
        self.dismiss(animated: true, completion: nil)
    }
}
