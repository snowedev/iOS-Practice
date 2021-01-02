//
//  CustomUILabel.swift
//  FunctionTest
//
//  Created by 이원석 on 2021/01/02.
//

import Foundation
import UIKit

//MARK: -자간
open class CustomLabel : UILabel {
    @IBInspectable open var characterSpacing:CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }

    }
}
