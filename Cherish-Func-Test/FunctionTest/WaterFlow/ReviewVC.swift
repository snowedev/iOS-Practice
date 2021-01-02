//
//  ReviewVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2021/01/01.
//

import UIKit

class ReviewVC: UIViewController,UITextFieldDelegate {
    var maxLength = 100
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
        keywordTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else {return false}
            
            // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
            if text.count >= maxLength && range.length == 0 && range.location < maxLength {
                return false
            }
            let newLength = keywordTextField.text?.utf16.count ?? 0 + string.utf16.count - range.length
            keywordCountingLabel.text =  "\(String(newLength))"+"/100"
                // Set value of the label
                // myCounter = newLength // Optional: Save this value
                // return newLength <= 25 // Optional: Set limits on input.
            
            return true
        }

}
