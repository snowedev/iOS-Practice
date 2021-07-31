//
//  ViewController.swift
//  test
//
//  Created by Wonseok Lee on 2021/08/01.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startAction(_ sender: Any) {
        if let dvc = self.storyboard?.instantiateViewController(withIdentifier: "loginNC") as? loginNC {
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
}

