//
//  TestTableViewCell.swift
//  prepareForReuseTest
//
//  Created by Wonseok Lee on 2021/07/10.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    static let identifier = "TestTableViewCell"
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testSwitch: UISwitch!
    
    var idx: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        testLabel.text = "default"
        testSwitch.isOn = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func tappedSwitch(_ sender: Any) {
        if let index = idx {
            print("현재 스위치를 누른 셀의 인덱스 값은=>",index)
            Test.shared.switchData[index] = !Test.shared.switchData[index]
        }
    }
}
