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
		view.layer.cornerRadius = 10
		view.layer.cornerCurve = .continuous
		view.backgroundColor = .systemGreen
		return view
	}()
	
	private let mockTwoView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 10
		view.layer.cornerCurve = .continuous
		view.backgroundColor = .systemBlue
		return view
	}()
	
	private let mockThreeView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 10
		view.layer.cornerCurve = .continuous
		view.backgroundColor = .systemRed
		return view
	}()
	
	private let maxDimmedAlpha: CGFloat = 0.6
	private let defaultHeight: CGFloat = 300
	private let dismissibleHeight: CGFloat = 200
	private let secondMaxContainerHeight: CGFloat = UIScreen.main.bounds.height - 300
	private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
	
	// keep updated with new height
	private var currentContainerHeight: CGFloat = 300
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
		configureGesture()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		animateShowDimmedView()
		animatePresentContainer(300)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		configureLayout()
	}
	
	private func configureUI() {
		view.addSubview(dimmedView)
		view.addSubview(contentView)
		
		contentView.flex.direction(.column).define {
			$0.addItem().direction(.row).justifyContent(.spaceEvenly).margin(.init(10)).define {
					$0.addItem(mockView).height(50).marginRight(10).grow(1)
					$0.addItem(mockTwoView).height(50).grow(1)
				}
			
			$0.addItem(mockThreeView).margin(UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)).grow(1)
		}
	}
	
	private func configureLayout() {
		dimmedView.pin.all()
		contentView.pin.left().right().bottom()
		contentView.flex.layout(mode: .fitContainer)
	}
	
	private func configureGesture() {
		let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
		panGesture.delaysTouchesBegan = false
		panGesture.delaysTouchesEnded = false
		view.addGestureRecognizer(panGesture)
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
			if newHeight < maximumContainerHeight {
				// Keep updating the height constraint
				contentView.flex.height(newHeight)
				// refresh layout
				view.layoutIfNeeded()
			}
		case .ended:
			// This happens when user stop drag,
			// so we will get the last height of container
			// Condition 1: If new height is below min, dismiss controller
			if newHeight < dismissibleHeight {
				self.animateDismissBottomSheet()
			}
			else if newHeight < defaultHeight {
				// Condition 2: If new height is below default, animate back to default
				animatePresentContainer(defaultHeight)
			}
			else if newHeight < maximumContainerHeight && isDraggingDown {
				// Condition 3: If new height is below max and going down, set to default height
				animatePresentContainer(secondMaxContainerHeight)
			}
			else if newHeight < secondMaxContainerHeight && isDraggingDown {
				// Condition 3: If new height is below max and going down, set to default height
				animatePresentContainer(defaultHeight)
			}
			else if newHeight > defaultHeight && secondMaxContainerHeight > newHeight && !isDraggingDown {
				// Condition 4: If new height is below max and going up, set to max height at top
				animatePresentContainer(secondMaxContainerHeight)
			}
			else if newHeight > secondMaxContainerHeight && !isDraggingDown {
				animatePresentContainer(maximumContainerHeight)
			}
		default:
			break
		}
	}
	
	func animateShowDimmedView() {
		dimmedView.alpha = 0
		UIView.animate(withDuration: 0.4) {
			self.dimmedView.alpha = self.maxDimmedAlpha
		}
	}
	
	private func animatePresentContainer() {
		UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
			self.dimmedView.alpha = 0.7
			self.contentView.flex.height(300)
			self.contentView.flex.markDirty()
			self.contentView.flex.layout()
			self.contentView.setNeedsLayout()
			self.view.layoutIfNeeded()
		}, completion: nil)
	}
	
	func animatePresentContainer(_ height: CGFloat) {
		UIView.animate(withDuration: 0.4) {
			self.contentView.flex.height(height)
			self.contentView.flex.markDirty()
			self.contentView.flex.layout()
			self.contentView.setNeedsLayout()
			self.view.layoutIfNeeded()
		}
		// Save current height
		currentContainerHeight = height
	}
	
	private func animateDismissBottomSheet() {
		UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
			self.dimmedView.alpha = 0.0
			self.contentView.flex.height(0)
			self.contentView.flex.markDirty()
			self.contentView.flex.layout()
			self.contentView.setNeedsLayout()
			self.view.layoutIfNeeded()
		}, completion: { _ in
			self.dismiss(animated: false)
		})
	}
}
