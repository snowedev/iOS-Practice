//
//  testTVCell.swift
//  test-tableView
//
//  Created by Wonseok Lee on 2021/06/30.
//

import UIKit

class testTVCell: UITableViewCell {
    static let identifier = "testTVCell"
    
    @IBOutlet weak var testLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
