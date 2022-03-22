//
//  anchorHandleView.swift
//  FlexibleBottomSheet
//
//  Created by Wonseok Lee on 2022/03/22.
//

import UIKit
import PinLayout
import Then

final class anchorHandleView: UIView {
	
	private lazy var titleLabel = UILabel().then {
		$0.font = .systemFont(ofSize: 15, weight: .medium)
		$0.textColor = .black
	}
	
	private lazy var anchorButton = UIButton().then {
		$0.setImage(.init(systemName: "chevron.down"), for: .normal)
		$0.tintColor = .black
	}
	
	init(title: String) {
		super.init(frame: .zero)
		configureUI(title: title)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		configureLayout()
	}
	
	private func configureUI(title: String) {
		addSubview(titleLabel)
		addSubview(anchorButton)
		self.titleLabel.text = title
		self.backgroundColor = .systemBackground
		
	}
	
	private func configureLayout() {
		titleLabel.pin.sizeToFit().left(15).vCenter()
		anchorButton.pin.sizeToFit().right(15).vCenter()
		self.pin.width(100%).height(50)
	}
}
