//
//  KeywordCVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2021/01/02.
//

import UIKit

class KeywordCVC: UICollectionViewCell {
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var keywordView: UIView!{
        didSet{
            keywordView.makeRounded(cornerRadius: 20.0)
        }
    }
    static let identifier = "KeywordCVC"
    
    static func nib() -> UINib {
            return UINib(nibName: "KeywordCVC", bundle: nil)
        }
        override func awakeFromNib() {
            super.awakeFromNib()
        }
}
