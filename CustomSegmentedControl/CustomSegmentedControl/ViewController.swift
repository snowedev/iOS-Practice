//
//  ViewController.swift
//  CustomSegmentedControl
//
//  Created by Bruno Faganello Neto on 08/07/18.
//  Copyright © 2018 Faganello. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CustomSegmentedControlDelegate{
    func change(to index: Int) {
        print("\(index)")
        switch index {
                    case 0:
                        secondhandSellingContainer.alpha = 1.0
                        neighborlifeContainer.alpha = 0.0
                        //categoryBtn.isHidden = false
                        break
                    case 1:
                        secondhandSellingContainer.alpha = 0.0
                        neighborlifeContainer.alpha = 1.0
                        //categoryBtn.isHidden = true
                        break
                    default:
                        break
        
                }

    }
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["중고거래","동네생활"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
    
    @IBOutlet weak var secondhandSellingContainer: UIView!
    @IBOutlet weak var neighborlifeContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interfaceSegmented.delegate = self
        secondhandSellingContainer.alpha = 1.0
        neighborlifeContainer.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

