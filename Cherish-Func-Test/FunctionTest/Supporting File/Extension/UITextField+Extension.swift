//
//  UITextField+Extension.swift
//  FunctionTest
//
//  Created by 이원석 on 2021/01/01.
//

import Foundation
import UIKit

extension UITextField{
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    func addRightPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }

}
