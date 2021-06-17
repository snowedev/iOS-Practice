//
//  LaterVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2021/01/03.
//

import UIKit

class LaterVC: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    let date = [1,2,3,4,5,6,7]
    var test = 21
    @IBOutlet weak var dateChangeLabel: UILabel!
    @IBOutlet weak var laterView: UIView!{
        didSet{
            laterView.makeRounded(cornerRadius: 20.0)
        }
    }
    @IBOutlet weak var laterPickerView: UIPickerView!{
        didSet{
            laterPickerView.delegate = self
            laterPickerView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /// 하나의 PickerView 안에 몇 개의 선택 가능한 리스트를 표시할 것인지
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    /// PickerView에 표시될 항목의 개수를 반환하는 메서드
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return date.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(date[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dateChangeLabel.text = "12월"+"\(test+date[row])"+"일에 물주기"
    }
    
    
}

//extension UIViewController: UIPickerViewDelegate, UIPickerViewDataSource{
//    /// 하나의 PickerView 안에 몇 개의 선택 가능한 리스트를 표시할 것인지
//    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        1
//    }
//
//    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return date.count
//    }
//
//
//}
