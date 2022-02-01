//
//  Extension.swift
//  flexLayout-practice
//
//  Created by Wonseok Lee on 2022/02/01.
//

import UIKit

extension UIView {
    // MARK: Add SubView+Then
    @discardableResult
    func add<T: UIView>(_ subview: T, then closure: ((T) -> Void)? = nil) -> T {
        addSubview(subview)
        closure?(subview)
        return subview
    }
    
    @discardableResult
    func adds<T: UIView>(_ subviews: [T], then closure: (([T]) -> Void)? = nil) -> [T] {
        subviews.forEach { addSubview($0) }
        closure?(subviews)
        return subviews
    }
}
