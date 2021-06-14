//
//  RefreshTVCell.swift
//  RefreshControl
//
//  Created by Wonseok Lee on 2021/06/15.
//

import UIKit

class RefreshTVCell: UITableViewCell {
    static let identifier = "RefreshTVCell"
    
    @IBOutlet weak var sampleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: String) {
        sampleLabel.text = data
    }

}
