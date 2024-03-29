//
//  UIView+Chainable.swift
//  UIKit_Like_SwiftUI
//
//  Created by 60105116 on 2022/01/11.
//

import UIKit

extension UIView: Chainable {}
extension Chain where T : UIView {
    func background(color: UIColor) -> Chain {
        origin.backgroundColor = color
        return self
    }
    
    func cornerRadius(_ r: CGFloat) -> Chain {
        origin.layer.cornerRadius = r
        origin.clipsToBounds = true
        return self
    }
    
    func add(to parent: UIView) -> Chain {
        parent.addSubview(origin)
        return self
    }
    
    func size(width: CGFloat, height: CGFloat) -> Chain {
        // https://zeddios.tistory.com/474
        origin.translatesAutoresizingMaskIntoConstraints = false
        origin.widthAnchor.constraint(equalToConstant: width).isActive = true
        origin.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    func size(_ size: CGSize) -> Chain {
        return self.size(width: size.width, height: size.height)
    }
    
    func position(x: CGFloat, y: CGFloat) -> Chain {
        guard let parent = origin.superview else { return self }
        origin.translatesAutoresizingMaskIntoConstraints = false
        origin.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: x).isActive = true
        origin.topAnchor.constraint(equalTo: parent.topAnchor, constant: y).isActive = true
        
        return self
    }
}
