//
//  MyTableViewCell.swift
//  TableView_test
//
//  Created by 이원석 on 2020/10/25.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userContentLabel: UILabel!
    
    // cell이 렌더링 될 때(그려질 때) 호출 됨
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("MyTableViewCell-awakeFromNib called")
        
        // userProfileImage를 둥글게 하기 위함
        userProfileImage.layer.cornerRadius = userProfileImage.frame.width / 2
    }
}
