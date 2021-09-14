//
//  UIButton+.swift
//  URLSession+Caching
//
//  Created by Wonseok Lee on 2021/09/14.
//

import UIKit

extension UIButton {
    func setupButton(title: String, color: UIColor, font: UIFont, backgroundColor: UIColor, state: UIControl.State, radius: CGFloat) {
        self.setTitle(title, for: state)
        self.setTitleColor(color, for: state)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        self.setRounded(radius: radius)
    }
}
