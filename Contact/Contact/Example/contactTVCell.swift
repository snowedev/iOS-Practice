//
//  contactTVCell.swift
//  Contact
//
//  Created by Wonseok Lee on 2021/06/14.
//

import UIKit

class contactTVCell: UITableViewCell {
    static let identifier = "contactTVCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
