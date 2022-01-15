//
//  TransactionCell.swift
//  Diffable
//
//  Created by Wonseok Lee on 2022/01/15.
//

import UIKit
import SnapKit
import Then

final class TransactionCell: UITableViewCell {
    private lazy var timeLabel = UILabel().then {
        $0.textColor = .black
    }
    private lazy var gistLabel = UILabel().then {
        $0.textColor = .black
    }
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .black
    }
    private lazy var ipjiLabel = UILabel().then {
        $0.textColor = .black
    }
    private lazy var moneyLabel = UILabel().then {
        $0.textColor = .black
    }
    private lazy var timeSectionStackView = UIStackView(arrangedSubviews: [timeLabel, gistLabel])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setNil()
    }
    
    private func setNil() {
        self.timeLabel.text = nil
        self.gistLabel.text = nil
        self.titleLabel.text = nil
        self.ipjiLabel.text = nil
        self.moneyLabel.text = nil
    }
    
    func dataBinding(model: Transaction) {
        self.timeLabel.text = "\(model.time)"
        self.gistLabel.text = "\(model.gist)"
        self.moneyLabel.text = "\(model.money)"
        self.ipjiLabel.text = model.ipji == 1 ? "입금" : "출금"
        self.titleLabel.text = "\(model.title)"
    }
}

extension TransactionCell {
    private func setLayout() {
        contentView.backgroundColor = .white
        selectionStyle = .none
        timeSectionLayout()
        titleSectionLayout()
        rightSectionLayout()
    }
    
    private func timeSectionLayout() {
        contentView.add(timeSectionStackView) {
            $0.snp.makeConstraints {
                $0.top.left.equalToSuperview().offset(5)
            }
        }
    }
    
    private func titleSectionLayout() {
        contentView.add(titleLabel) {
            $0.snp.makeConstraints {
                $0.top.equalTo(self.timeLabel.snp.bottom)
                $0.left.equalTo(self.timeLabel)
                $0.bottom.equalToSuperview().inset(5)
            }
        }
    }
    
    private func rightSectionLayout() {
        contentView.adds([ipjiLabel, moneyLabel]) {
            $0[0].snp.makeConstraints {
                $0.top.equalToSuperview().offset(5)
                $0.right.equalToSuperview().inset(5)
            }
            
            $0[1].snp.makeConstraints {
                $0.top.equalTo(self.ipjiLabel.snp.bottom)
                $0.right.equalTo(self.ipjiLabel)
            }
        }
    }
}
