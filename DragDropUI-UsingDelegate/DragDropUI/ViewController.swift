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
		collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
		collectionView.delegate = self
		collectionView.dragDelegate = self
		collectionView.dropDelegate = self
		collectionView.dragInteractionEnabled = true
		dataSource = DragDropCollectionDataSource(collectionView: self.collectionView)
		collectionView.dataSource = dataSource
		
		collectionView.backgroundColor = .white
		view.addSubview(collectionView)
	}
	
	private func snapshotInitialSetting() {
		var snapshot = dataSource.snapshot()
		snapshot.appendSections([.main, .favorite])
		snapshot.appendItems(ColorModel.data, toSection: .main)
		snapshot.appendItems(ColorModel.secdata, toSection: .favorite)
		dataSource.apply(snapshot, animatingDifferences: false)
	}
	
	/// reorderItems method
	/// This method moves a cell from the sourceIndexPath to the destinationIndexPath within the same UICollectionView
	///
	/// - Parameters:
	///   - coordinator: UICollectionViewDropCoordinator obtained in performDropWith
	///   - destinationIndexPath: IndexPath where user dropped the element.
	///   - collectionView: UICollectionView object where reordering is done.
	private func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {
		let items = coordinator.items
		if items.count == 1, let item = items.first, let sourceIndexPath = item.sourceIndexPath {
			var destIndexPath = destinationIndexPath
			if destIndexPath.row >= collectionView.numberOfItems(inSection: destIndexPath.section) {
				destIndexPath.row = collectionView.numberOfItems(inSection: destIndexPath.section) - 1
			}
			
			guard let fromItem = dataSource.itemIdentifier(for: sourceIndexPath),
				  let toItem = dataSource.itemIdentifier(for: destinationIndexPath),
				  sourceIndexPath != destinationIndexPath else { return }
			var snap = dataSource.snapshot()
			snap.deleteItems([fromItem])
			
			if destinationIndexPath.row > sourceIndexPath.row {
				snap.insertItems([fromItem], afterItem: toItem)
			} else {
				snap.insertItems([fromItem], beforeItem: toItem)
			}
			
			print(sourceIndexPath, destinationIndexPath)
			dataSource.apply(snap, animatingDifferences: true)
			coordinator.drop(items.first!.dragItem, toItemAt: destIndexPath)
		}
	}
}

extension ViewController: UICollectionViewDelegate,
						  UICollectionViewDelegateFlowLayout,
						  UICollectionViewDragDelegate,
						  UICollectionViewDropDelegate {
	
	func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		guard let item = dataSource.itemIdentifier(for: indexPath) else { return [] }
		let itemProvider = NSItemProvider(object: item.id.uuidString as NSString)
		let dragItem = UIDragItem(itemProvider: itemProvider)
		dragItem.localObject = item
		return [dragItem]
	}
	
	func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
		return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
	}
	
	func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
		var destinationIndexPath: IndexPath
		if let indexPath = coordinator.destinationIndexPath {
			destinationIndexPath = indexPath
		} else {
			let section = collectionView.numberOfSections - 1
			let row = collectionView.numberOfItems(inSection: section)
			destinationIndexPath = IndexPath(row: row, section: section)
		}
		switch coordinator.proposal.operation {
		case .move:
			self.reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
			break
		case .copy: return
		default: return
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width/3.2, height: view.frame.width/3.2)
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

//	override func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
//		return true
//	}
//
//
//	override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//
//		guard let fromItem = itemIdentifier(for: sourceIndexPath),
//			  let toItem = itemIdentifier(for: destinationIndexPath),
//			  sourceIndexPath != destinationIndexPath else { return }
//		var snap = snapshot()
//		snap.deleteItems([fromItem])
//
//		if destinationIndexPath.row > sourceIndexPath.row {
//			snap.insertItems([fromItem], afterItem: toItem)
//		} else {
//			snap.insertItems([fromItem], beforeItem: toItem)
//		}
//
//		apply(snap, animatingDifferences: false)
//	}
}
