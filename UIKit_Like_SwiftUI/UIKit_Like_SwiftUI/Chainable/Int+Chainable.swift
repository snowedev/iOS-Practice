//
//  Int+Chainable.swift
//  UIKit_Like_SwiftUI
//
//  Created by 60105116 on 2022/01/11.
//

import Foundation

extension Int: Chainable {}
extension Chain where T == Int {
    func increase() -> Chain {
        origin += 1
        return self
    }
    
    func decrease() -> Chain {
        origin -= 1
        return self
    }
}
