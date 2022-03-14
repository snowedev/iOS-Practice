//
//  ViewController.swift
//  DragDropUI
//
//  Created by 60156673 on 2022/03/11.
//
import UIKit

class ViewController: UIViewController {
	
	private let layout = UICollectionViewFlowLayout()
	private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
	var dataSource: DragDropCollectionDataSource!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureCollectionView()
		snapshotInitialSetting()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		collectionView.frame = view.bounds
	}
	
	private func configureCollectionView() {
		layout.scrollDirection = .vertical
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
		layout.itemSize = CGSize(width: view.frame.width/3.2, height: view.frame.width/3.2)
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		dataSource = DragDropCollectionDataSource(collectionView: self.collectionView)
		collectionView.dataSource = dataSource
		
		collectionView.backgroundColor = .white
		view.addSubview(collectionView)
		
		let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:) ))
		collectionView.addGestureRecognizer(gesture)
	}
	
	private func snapshotInitialSetting() {
		var snapshot = dataSource.snapshot()
		snapshot.appendSections([.main, .favorite])
		snapshot.appendItems(ColorModel.data, toSection: .main)
		snapshot.appendItems(ColorModel.secdata, toSection: .favorite)
		dataSource.apply(snapshot, animatingDifferences: false)
	}
	
	@objc
	func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
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

class DragDropCollectionDataSource: UICollectionViewDiffableDataSource<Section, ColorModel> {
	init(collectionView: UICollectionView) {
		super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
			cell.backgroundColor = itemIdentifier.color
			return cell
		}
	}
	
	// MARK: Re-Order

	override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
		return true
	}


	override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

		guard let fromItem = itemIdentifier(for: sourceIndexPath),
			  let toItem = itemIdentifier(for: destinationIndexPath),
			  sourceIndexPath != destinationIndexPath else { return }
		var snap = snapshot()
		snap.deleteItems([fromItem])

		if destinationIndexPath.row > sourceIndexPath.row {
			snap.insertItems([fromItem], afterItem: toItem)
		} else {
			snap.insertItems([fromItem], beforeItem: toItem)
		}

		apply(snap, animatingDifferences: false)
	}
}
