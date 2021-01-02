//
//  ReviewVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2021/01/01.
//

import UIKit
import WSTagsField
class ReviewVC: UIViewController,UITextFieldDelegate {
    var maxLength = 100 /// 최대 글자 수
    var keyword = [String]() /// 키워드 배열
    
    //MARK: -@IBOutlet
    @IBOutlet weak var keywordCollectionView: UICollectionView!
    @IBOutlet weak var keywordTextField: UITextField!{
        didSet{
            textFieldDoneBtnMake(text_field: keywordTextField)
            keywordTextField.addLeftPadding()
            keywordTextField.addRightPadding()
        }
    }
    @IBOutlet weak var memoTextField: UITextField!{
        didSet{
            memoTextField.addLeftPadding()
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
        self.keywordCollectionView.register(KeywordCVC.nib(), forCellWithReuseIdentifier: KeywordCVC.identifier)
        keywordCollectionView.delegate = self
        keywordCollectionView.dataSource = self
        keywordTextField.delegate = self
    }
    
    //MARK: -사용자 정의 함수
    func textFieldDoneBtnMake(text_field : UITextField)
    {
        let ViewForDoneButtonOnKeyboard = UIToolbar()
        ViewForDoneButtonOnKeyboard.sizeToFit()
        let btnDoneOnKeyboard = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnFromKeyboardClicked))
        ViewForDoneButtonOnKeyboard.items = [btnDoneOnKeyboard]
        text_field.inputAccessoryView = ViewForDoneButtonOnKeyboard
    }
    
    @objc func doneBtnFromKeyboardClicked (sender: Any) {
        print("Done Button Clicked.")
        
        if keyword.count >= 3{
            print("full")
            keywordTextField.text = ""
            self.view.endEditing(true)
        }else{
            keyword.append(keywordTextField.text!)
            keywordTextField.text = ""
            print(keyword)
            keywordCollectionView.reloadData()
            //Hide Keyboard by endEditing or Anything you want. self.view.endEditing(true)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        
        /// 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
        if text.count >= maxLength && range.length == 0 && range.location < maxLength {
            return false
        }
        let newLength = keywordTextField.text?.utf16.count ?? 0 + string.utf16.count - range.length
        keywordCountingLabel.text =  "\(String(newLength))"+"/100"
        /// Set value of the label
        /// myCounter = newLength // Optional: Save this value
        /// return newLength <= 25 // Optional: Set limits on input.
        
        return true
    }
    
    ///Return 눌렀을 때 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    ///화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK: -Protocols
extension ReviewVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// 키워드 터치시 삭제
        keyword.remove(at: indexPath.row)
        keywordCollectionView.reloadData()
    }
    
}
extension ReviewVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyword.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCVC.identifier, for: indexPath) as? KeywordCVC else{
            return UICollectionViewCell()
        }
        
        cell.keywordLabel.text = keyword[indexPath.row]
        
        return cell
    }
}
extension ReviewVC: UICollectionViewDelegateFlowLayout{
    
    //MARK: - Cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (collectionView.frame.width-40)/3, height: collectionView.frame.height)
    }
    
    //MARK: - Cell간의 좌우간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }

    //MARK: - 마진
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
