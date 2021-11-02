//
//  UIViewController+.swift
//  MVVM-SimpleEx
//
//  Created by Wonseok Lee on 2021/11/02.
//

import UIKit

extension UIViewController {
    /**
     - Description: 화면 터치시 작성 종료
     */
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
