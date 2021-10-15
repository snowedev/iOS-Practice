//
//  ViewController.swift
//  SwitchTab
//
//  Created by Wonseok Lee on 2021/10/15.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    @IBOutlet weak var movingView: UIView!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func firstBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.movingView.snp.remakeConstraints {
                $0.top.bottom.left.equalToSuperview()
                $0.right.equalToSuperview().inset(UIScreen.main.bounds.width/2)
            }
            
            self.view.layoutIfNeeded()
        })
    }
    @IBAction func secBtnAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.movingView.snp.remakeConstraints {
                $0.left.equalToSuperview().offset(UIScreen.main.bounds.width/2)
                $0.top.bottom.right.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        })
    }
}

