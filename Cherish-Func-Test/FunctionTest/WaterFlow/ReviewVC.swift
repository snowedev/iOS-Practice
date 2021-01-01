//
//  ReviewVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2021/01/01.
//

import UIKit

class ReviewVC: UIViewController {

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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
