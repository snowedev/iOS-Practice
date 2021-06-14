//
//  UITextField+Extension.swift
//  CommonlyUsedStorage
//
//  Created by Wonseok Lee on 2021/06/14.
//

import UIKit

extension UITextField{
    // MARK: - TextField내에서 좌,우측 패딩 값 주기
    func addLeftPadding(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    func addRightPadding(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
}
