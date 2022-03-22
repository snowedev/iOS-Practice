//
//  BottomSheetViewController.swift
//  FlexibleBottomSheet
//
//  Created by Wonseok Lee on 2022/03/20.
//

import UIKit
import PinLayout
import FlexLayout
import Then

enum SheetHandleType {
	case handle
	case anchor
	case none
}

// Percent
enum BottomSheetHeightType: CGFloat {
	case max = 90
	case medium = 60
	case min = 30
}

protocol BottomSheetPresentableListener: AnyObject {
	func didActionDismissBottomSheet()
}

final class BottomSheetViewController: UIViewController {
	
	weak var listener: BottomSheetPresentableListener?
	
	private let dimmedView = UIView().then {
		$0.backgroundColor = UIColor.black.withAlphaComponent(0.3)
		$0.alpha = 0.0
	}
	
	private let bottomSheet = UIView().then {
		$0.backgroundColor = .white
		$0.layer.cornerRadius = 15
		$0.layer.cornerCurve = .continuous
		$0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		$0.clipsToBounds = true
	}
	
	private var sheetHandlerView = UIView()
	
	private let sheetContentView = UIView().then {
		$0.backgroundColor = .systemRed
	}
	
	private let handleType: SheetHandleType
	private let screenHeight = UIScreen.main.bounds.height
	private let maxDimmedAlpha: CGFloat = 0.6
	private var currentContainerHeight: CGFloat = 300
	
	private lazy var minContainerHeight: CGFloat = screenHeight * (BottomSheetHeightType.min.rawValue/100)
	private lazy var dismissibleHeight: CGFloat = minContainerHeight - 100
	private lazy var mediumContainerHeight: CGFloat = screenHeight * (BottomSheetHeightType.medium.rawValue/100)
	private lazy var maxContainerHeight: CGFloat = screenHeight * (BottomSheetHeightType.max.rawValue/100)
	
	init(handleType: SheetHandleType) {
		self.handleType = handleType
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureHandleView(type: handleType)
		configureUI()
		configureGesture()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		presentDimmedViewSmoothly()
		presentSheetWithAnimation(.min)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
	
	private func configureHandleView(type: SheetHandleType) {
		switch type {
		case .handle:
			sheetHandlerView = defaultHandleView()
		case .anchor:
			sheetHandlerView = anchorHandleView(title: "TITLE")
		case .none:
			break
		}
	}
	
	private func configureUI() {
		view.addSubview(dimmedView)
		view.addSubview(bottomSheet)
		
		bottomSheet.flex.direction(.column).define {
			$0.addItem(sheetHandlerView)
			$0.addItem(sheetContentView).marginTop(15).grow(1)
		}
	}
	
	private func configureLayout() {
		dimmedView.pin.all()
		bottomSheet.pin.left().right().bottom()
		bottomSheet.flex.layout(mode: .fitContainer)
	}
	
	private func configureGesture() {
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
		panGesture.delaysTouchesBegan = false
		panGesture.delaysTouchesEnded = false
		sheetHandlerView.addGestureRecognizer(panGesture)
	}
	
	@objc
	private func handlePanGesture(gesture: UIPanGestureRecognizer) {
		let translation = gesture.translation(in: view)
		let isDraggingDown = translation.y > 0
		let newHeight = currentContainerHeight - translation.y
		
		print("Pan gesture y offset: \(translation.y)")
		print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
		
		switch gesture.state {
			// This state will occur when user is dragging
		case .changed:
			presentSheetWithoutAnimation(newHeight)
			// This happens when user stop drag,
		case .ended:
			if newHeight < minContainerHeight {
				isDraggingDown ? dismissSheetWithAnimation() : presentSheetWithAnimation(.min)
			} else if newHeight < mediumContainerHeight {
				isDraggingDown ? presentSheetWithAnimation(.min) : presentSheetWithAnimation(.medium)
			} else {
				isDraggingDown ? presentSheetWithAnimation(.medium) : presentSheetWithAnimation(.max)
			}
		default:
			break
		}
	}
}

private extension BottomSheetViewController {
	func presentDimmedViewSmoothly() {
		dimmedView.alpha = 0
		UIView.animate(withDuration: 0.2) {
			self.dimmedView.alpha = self.maxDimmedAlpha
		}
	}
	
	func presentSheetWithAnimation(_ height: BottomSheetHeightType) {
		let newHeight = self.screenHeight * (height.rawValue/100)
		UIView.animate(withDuration: 0.4) {
			self.bottomSheet.flex.height(newHeight)
			self.bottomSheet.flex.markDirty()
			self.bottomSheet.flex.layout()
			self.bottomSheet.setNeedsLayout()
			self.view.layoutIfNeeded()
		}
		// Save current height
		currentContainerHeight = newHeight
	}
	
	func presentSheetWithoutAnimation(_ height: CGFloat) {
		self.bottomSheet.flex.height(height)
		self.bottomSheet.flex.markDirty()
		self.bottomSheet.flex.layout()
		self.view.layoutIfNeeded()
	}
	
	func dismissSheetWithAnimation() {
		UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
			self.dimmedView.alpha = 0.0
			self.bottomSheet.flex.height(0)
			self.bottomSheet.flex.markDirty()
			self.bottomSheet.flex.layout()
			self.bottomSheet.setNeedsLayout()
			self.view.layoutIfNeeded()
		}, completion: { [weak self] _ in
			self?.dismiss(animated: false)
		})
	}
}
