//
//  ViewController.swift
//  DragDropUI
//
//  Created by 60156673 on 2022/03/11.
//

import UIKit

class ViewController: UIViewController {
	
	private var collectionView: UICollectionView?
	
	var colors: [UIColor] = [
		
		.blue,
		.systemRed,
		.systemBlue,
		.systemCyan,
		.systemPink,
		.systemBrown,
		.black,
		.systemPurple,
		.systemYellow
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		layout.itemSize = CGSize(width: view.frame.width/3.2, height: view.frame.width/3.2)
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collectionView?.delegate = self
		collectionView?.dataSource = self
		collectionView?.backgroundColor = .white
		view.addSubview(collectionView! )
		
		let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:) ))
		collectionView?.addGestureRecognizer(gesture)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		collectionView?.frame = view.bounds
	}
	
	@objc
	func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
		guard let collectionView = collectionView else {
			return
		}
		
		switch gesture.state {
			case .began:
				guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
					return
				}
				collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
			case .changed:
				collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView ))
			case .ended:
				collectionView.endInteractiveMovement()
			default:
				collectionView.cancelInteractiveMovement()
		}
	}
}

extension ViewController: UICollectionViewDelegate,
						  UICollectionViewDataSource,
						  UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return colors.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
		cell.backgroundColor = colors[indexPath.row]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width/3.2, height: view.frame.width/3.2)
	}
	
	// MARK: Re-Order
	
	func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		let item = colors.remove(at: sourceIndexPath.row)
		colors.insert(item, at: destinationIndexPath.row)
	}
}

