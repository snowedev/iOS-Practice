//
//  ReviewVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2021/01/01.
//

import UIKit

class ReviewVC: UIViewController {
    
    //MARK: -@IBOutlet
    @IBOutlet weak var keywordTextField: UITextField!{
        didSet{
            keywordTextField.addLeftPadding()
        }
    }
    @IBOutlet weak var memoTextField: UITextField!{
        didSet{
            memoTextField.addLeftTopPadding()
        }
    }
    @IBOutlet weak var keywordCountingLabel: UILabel!
    @IBOutlet weak var memoCountingLabel: UILabel!
    @IBOutlet weak var completeBtn: UIButton!{
        didSet{
            completeBtn.makeRounded(cornerRadius: 20.0)
        }
    }
    @IBOutlet weak var laterBtn: UIButton!{
        didSet{
            laterBtn.makeRounded(cornerRadius: 20.0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
