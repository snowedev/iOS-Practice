//
//  ViewController.swift
//  UIKit_Like_SwiftUI
//
//  Created by 60105116 on 2022/01/11.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let red = UIView().chain
            .add(to: view)
            .background(color: .red)
            .cornerRadius(10)
            .size(width: 100, height: 100)
            .constraint {
                $0.edges.equalToSuperview()
                    .inset(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
            } 
            .origin
        
        // green
        _ = UIView().chain
            .add(to: red)
            .background(color: .green)
            .cornerRadius(10)
            .constraint {
                $0.left.top.equalToSuperview().offset(100)
                $0.width.height.equalTo(200)
            }
        
        // blue
        _ = UIView().chain
            .add(to: red)
            .background(color: .blue)
            .cornerRadius(10)
            .constraint {
                $0.trailing.bottom.equalToSuperview().inset(100)
                $0.width.height.equalTo(200)
            }
        
        _ = UILabel().chain
            .add(to: view)
            .text("Hello World")
            .font(30, .medium)
            .color(.white)
            .constraint {
                $0.center.equalToSuperview()
            }
    }
}

