//
//  ViewController.swift
//  LottieTest
//
//  Created by Wonseok Lee on 2021/06/15.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    lazy var lottieView: AnimationView = {
        let animationView = AnimationView(name: "test")
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        animationView.stop()
        animationView.isHidden = true
        
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(lottieView)
    }

    @IBAction func startBtnTapped(_ sender: Any) {
        lottieView.isHidden = false
        lottieView.play()
    }
    
    @IBAction func stopBtnTapped(_ sender: Any) {
        lottieView.isHidden = true
        lottieView.stop()
    }
}

