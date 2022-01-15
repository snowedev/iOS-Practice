//
//  GetClassName+.swift
//  Diffable
//
//  Created by Wonseok Lee on 2022/01/15.
//

import UIKit

extension UITableViewCell {
    
    static var className: String {
        NSStringFromClass(self.classForCoder()).components(separatedBy: ".").last!
    }
    
     var className: String {
        NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
}
