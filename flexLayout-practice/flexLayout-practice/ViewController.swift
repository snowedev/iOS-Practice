//
//  ViewController.swift
//  flexLayout-practice
//
//  Created by Wonseok Lee on 2022/02/01.
//

import UIKit
import PinLayout
import Then


class ViewController: UIViewController {
    fileprivate let oneView = UIView().then { $0.backgroundColor = .green }
    fileprivate let twoView = UIView().then { $0.backgroundColor = .blue }
    fileprivate let threeView = UIView().then { $0.backgroundColor = .orange }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.view.adds([oneView, twoView, threeView]) {
            $0[0].pin.top(self.view.pin.readableMargins).size(200)
            $0[1].pin.after(of: self.oneView, aligned: .bottom).size(100)
            $0[2].pin.below(of: self.twoView, aligned: .right).size(50)
        }
    }
}

