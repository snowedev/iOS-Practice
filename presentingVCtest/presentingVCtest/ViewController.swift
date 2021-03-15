//
//  ViewController.swift
//  presentingVCtest
//
//  Created by 이원석 on 2020/10/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func touchUpBlue(_ sender: Any) {
        guard let blbl = self.storyboard?.instantiateViewController(identifier: "yellowViewController") else {
            return
        }
        
        self.present(blbl, animated: true, completion: nil)
    }
    //    @IBAction func bluebtn(_ sender: any) {
//        guard let blue = self.storyboard?.instantiateViewController(identifier: "yellowViewController") else { return }
//
//        self.present( blue, animated: true, completion: nil)
//    }
    
}

