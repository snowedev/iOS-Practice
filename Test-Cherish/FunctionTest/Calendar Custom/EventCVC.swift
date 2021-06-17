//
//  EventCVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/29.
//

import UIKit

class EventCVC: UICollectionViewCell {
    static let identifier = "EventCVC"
    
    static func nib() -> UINib {
            return UINib(nibName: "EventCVC", bundle: nil)
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
