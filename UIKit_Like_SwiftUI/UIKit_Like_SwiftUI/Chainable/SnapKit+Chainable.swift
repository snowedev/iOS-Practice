//
//  SnapKit+Chainable.swift
//  UIKit_Like_SwiftUI
//
//  Created by 60105116 on 2022/01/11.
//

import UIKit
import SnapKit

extension Chain where T: UIView {
    func constraint(_ maker: (ConstraintMaker) -> Void) -> Chain {
        origin.snp.makeConstraints(maker)
        return self
    }
    
    func updateConstraint(_ maker: (ConstraintMaker) -> Void) -> Chain {
        origin.snp.updateConstraints(maker)
        return self
    }
}
