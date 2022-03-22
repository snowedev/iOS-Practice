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
	
	private let bottomSheet: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 10
		view.layer.cornerCurve = .continuous
		view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		view.clipsToBounds = true
		return view
	}()
	
	private let sheetHandlerView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemGreen
		return view
	}()
	
	private let sheetContentView: UIView = {
		let view = UIView()
		view.backgroundColor = .systemRed
		return view
	}()
	
	private let maxDimmedAlpha: CGFloat = 0.6
	private let dismissibleHeight: CGFloat = 200
	
	private let lowContainerHeight: CGFloat = 300
	private let mediumContainerHeight: CGFloat = UIScreen.main.bounds.height - 300
	private let highContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
	
	private var currentContainerHeight: CGFloat = 300
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		configureGesture()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		presentDimmedViewSmoothly()
		presentSheetWithAnimation(300)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
	
	private func configureUI() {
		view.addSubview(dimmedView)
		view.addSubview(bottomSheet)
		
		bottomSheet.flex.direction(.column).define {
			$0.addItem(sheetHandlerView).height(50)
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
	func handlePanGesture(gesture: UIPanGestureRecognizer) {
		let translation = gesture.translation(in: view)
		print("Pan gesture y offset: \(translation.y)")
		
		let isDraggingDown = translation.y > 0
		print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
		
		// New height is based on value of dragging plus current container height
		let newHeight = currentContainerHeight - translation.y
		
		// Handle based on gesture state
		switch gesture.state {
		case .changed:
			// This state will occur when user is dragging
			if newHeight < highContainerHeight {
				presentSheetWithoutAnimation(newHeight)
			}
			
		case .ended:
			// This happens when user stop drag,
			// so we will get the last height of container
			
			if newHeight < dismissibleHeight {
				// Condition 1: If new height is below min, dismiss controller
				self.dismissSheetWithAnimation()
			} else if newHeight < lowContainerHeight {
				// Condition 2: If new height is below default, animate back to default
				presentSheetWithAnimation(lowContainerHeight)
			} else if newHeight < highContainerHeight && isDraggingDown {
				// Condition 3: If new height is below max and going down, set to medium height
				presentSheetWithAnimation(mediumContainerHeight)
			} else if newHeight < mediumContainerHeight && isDraggingDown {
				// Condition 4: If new height is below max and going down, set to default height
				presentSheetWithAnimation(lowContainerHeight)
			} else if newHeight > lowContainerHeight && mediumContainerHeight > newHeight && !isDraggingDown {
				// Condition 5: If new height is between low and medium and going up, set to medium height
				presentSheetWithAnimation(mediumContainerHeight)
			} else if newHeight > mediumContainerHeight && !isDraggingDown {
				// Condition 6: If new height is between medium and high and going up, set to highest height
				presentSheetWithAnimation(highContainerHeight)
			}
		default:
			break
		}
	}
	
	private func presentDimmedViewSmoothly() {
		dimmedView.alpha = 0
		UIView.animate(withDuration: 0.2) {
			self.dimmedView.alpha = self.maxDimmedAlpha
		}
	}
	
	private func presentSheetWithAnimation(_ height: CGFloat) {
		UIView.animate(withDuration: 0.3) {
			self.bottomSheet.flex.height(height)
			self.bottomSheet.flex.markDirty()
			self.bottomSheet.flex.layout()
			self.bottomSheet.setNeedsLayout()
			self.view.layoutIfNeeded()
		}
		// Save current height
		currentContainerHeight = height
	}
	
	private func presentSheetWithoutAnimation(_ height: CGFloat) {
		self.bottomSheet.flex.height(height)
		self.bottomSheet.flex.markDirty()
		self.bottomSheet.flex.layout()
		self.view.layoutIfNeeded()
	}
	
	private func dismissSheetWithAnimation() {
		UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
			self.dimmedView.alpha = 0.0
			self.bottomSheet.flex.height(0)
			self.bottomSheet.flex.markDirty()
			self.bottomSheet.flex.layout()
			self.bottomSheet.setNeedsLayout()
			self.view.layoutIfNeeded()
		}, completion: { _ in
			self.dismiss(animated: false)
		})
	}
}
