//
//  ViewController.swift
//  ActivityIndicator
//
//  Created by Wonseok Lee on 2021/06/15.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = self.view.center
        
        activityIndicator.color = .purple
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        
        activityIndicator.stopAnimating()
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(activityIndicator)
        // addSubview가 호출되는 순간에
        // activityIndicator는 메모리에 할당되기 시작할거에요!! (lazy 이기 때문)
    }

    @IBAction func startBtnTapped(_ sender: Any) {
        activityIndicator.startAnimating()
    }
    @IBAction func stopBtnTapped(_ sender: Any) {
        activityIndicator.stopAnimating()
    }
    
}

