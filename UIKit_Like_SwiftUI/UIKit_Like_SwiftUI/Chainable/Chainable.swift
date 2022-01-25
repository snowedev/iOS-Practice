//
//  Chainable.swift
//  UIKit_Like_SwiftUI
//
//  Created by 60105116 on 2022/01/11.
//

import Foundation

class Chain<T> {
    var origin: T
    
    init(origin: T) {
        self.origin = origin
    }
}

protocol Chainable {}
extension Chainable {
    var chain: Chain<Self> {
        return Chain(origin: self)
    }
}
