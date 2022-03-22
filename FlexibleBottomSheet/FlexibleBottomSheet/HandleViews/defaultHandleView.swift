//
//  defaultHandleView.swift
//  FlexibleBottomSheet
//
//  Created by Wonseok Lee on 2022/03/22.
//

import UIKit
import PinLayout
import Then

final class defaultHandleView: UIView {
	
	private let horizontalHandle = UIView().then {
		$0.backgroundColor = .black
		$0.layer.cornerRadius = 3
		$0.layer.cornerCurve = .continuous
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configureUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		configureLayout()
	}
	
	private func configureUI() {
		addSubview(horizontalHandle)
		self.backgroundColor = .systemBackground
	}
	
	private func configureLayout() {
		horizontalHandle.pin.width(15%).height(6).hCenter().top(8)
		self.pin.width(100%).height(50)
	}
}
