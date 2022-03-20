//
//  BottomSheetViewController.swift
//  FlexibleBottomSheet
//
//  Created by Wonseok Lee on 2022/03/20.
//

import UIKit
import PinLayout
import FlexLayout

final class BottomSheetViewController: UIViewController {
	private let dimmedView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.darkGray.withAlphaComponent(0.7)
		view.alpha = 0.0
		return view
	}()
	
	private let contentView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 10
		view.layer.cornerCurve = .continuous
		view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		view.clipsToBounds = true
		return view
	}()
	
	private let mockView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemGreen
		return view
	}()
	
	private let mockTwoView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemBlue
		return view
	}()
	
	private let mockThreeView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemRed
		return view
	}()
	
	private let defaultHeight: CGFloat = 300
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		animatePresentContainer()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
	
	private func configureUI() {
		view.addSubview(dimmedView)
		view.addSubview(contentView)
		
		contentView.flex.direction(.column).define {
			$0.addItem().direction(.row).justifyContent(.spaceEvenly).define {
				$0.addItem(mockView).height(50).grow(1)
				$0.addItem(mockTwoView).height(50).grow(1)
			}
			
			$0.addItem(mockThreeView).grow(1)
		}
	}
	
	private func configureLayout() {
		dimmedView.pin.all()
		contentView.pin.left().right().bottom()
		contentView.flex.layout(mode: .fitContainer)
	}
	
	func animatePresentContainer() {
		UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
			self.dimmedView.alpha = 0.7
			self.contentView.flex.height(300)
			self.contentView.flex.markDirty()
			self.contentView.flex.layout()
			self.contentView.setNeedsLayout()
			self.view.layoutIfNeeded()
		}, completion: nil)
	}
}
