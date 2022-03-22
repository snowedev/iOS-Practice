//
//  ViewController.swift
//  FlexibleBottomSheet
//
//  Created by Wonseok Lee on 2022/03/20.
//

import UIKit
import PinLayout
import FlexLayout

class ViewController: UIViewController {

	private lazy var showBottomSheetButton : UIButton = {
		let button = UIButton()
		button.setTitle("Show", for: .normal)
		button.setTitleColor(.systemGreen, for: .normal)
		button.addTarget(self, action: #selector(showBottomSheet), for: .touchUpInside)
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
	
	private func configureUI() {
		view.addSubview(showBottomSheetButton)
	}
	
	private func configureLayout() {
		showBottomSheetButton.pin.hCenter().vCenter().sizeToFit()
	}
	
	@objc
	func showBottomSheet() {
		let bottomSheetVC = BottomSheetViewController(handleType: .handle)
		bottomSheetVC.modalPresentationStyle = .overFullScreen
		self.present(bottomSheetVC, animated: false, completion: nil)
	}
}
