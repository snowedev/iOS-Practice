//
//  UILabel+Chainable.swift
//  UIKit_Like_SwiftUI
//
//  Created by 60105116 on 2022/01/11.
//

import UIKit

extension Chain where T: UILabel {
    func text(_ text: String) -> Chain {
        origin.text = text
        return self
    }
    
    func font(_ font: UIFont) -> Chain {
        origin.font = font
        return self
    }
    
    func font(_ size: CGFloat, _ weight: UIFont.Weight) -> Chain {
        return font(UIFont.systemFont(ofSize: size, weight: weight))
    }
    
    func color(_ color: UIColor) -> Chain {
        origin.textColor = color
        return self
    }
}
