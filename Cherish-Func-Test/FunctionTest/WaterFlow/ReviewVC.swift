//
//  ReviewVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2021/01/01.
//

import UIKit

class ReviewVC: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    //    var keywordLength = 10 /// 키워드 최대 글자 수
    //    var memoLength = 100 /// 메모 최대 글자 수
    var keyword = [String]() /// 키워드 배열
    
    //MARK: -@IBOutlet
    @IBOutlet weak var keywordCollectionView: UICollectionView!{
        didSet{
            self.keywordCollectionView.register(KeywordCVC.nib(), forCellWithReuseIdentifier: KeywordCVC.identifier)
            keywordCollectionView.delegate = self
            keywordCollectionView.dataSource = self
        }
    }
    @IBOutlet weak var keywordTextField: UITextField!{
        didSet{
            keywordTextField.delegate = self
            textFieldDoneBtnMake(text_field: keywordTextField)
            /// TextField 커서 Padding
            keywordTextField.addLeftPadding()
            keywordTextField.addRightPadding()
        }
    }
    @IBOutlet weak var memoTextView: UITextView!{
        didSet{
            memoTextView.delegate = self
            memoTextView.makeRounded(cornerRadius: 10.0)
            /// TextView 커서 Padding
            memoTextView.textContainerInset = UIEdgeInsets(top: 10, left: 12, bottom: 20, right: 12);
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
        textViewPlaceholder()
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
    
    /// 키워드 부분 글자수 Counting
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newKeywordLength = currentCharacterCount + string.count - range.length
        keywordCountingLabel.text =  "\(String(newKeywordLength))"+"/10"
        return newKeywordLength <= 10
    }
    
    /// 메모 부분 글자수 Counting
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = memoTextView.text?.count ?? 0
        if text == "\n" {
            textView.resignFirstResponder()
        }
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newMemoLength = currentCharacterCount + text.count - range.length
        memoCountingLabel.text =  "\(String(newMemoLength))"+"/100"
        return newMemoLength <= 100
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewPlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if memoTextView.text == "" {
            textViewPlaceholder()
        }
    }
    
    func textViewPlaceholder() {
        if memoTextView.text == "메모" {
            memoTextView.text = ""
            memoTextView.textColor = .label
        }
        else if memoTextView.text == "" {
            memoTextView.text = "메모"
            memoTextView.textColor = UIColor.lightGray
        }
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
