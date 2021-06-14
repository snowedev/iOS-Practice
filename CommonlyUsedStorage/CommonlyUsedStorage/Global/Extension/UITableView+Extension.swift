//
//  UITableView+Extension.swift
//  CommonlyUsedStorage
//
//  Created by Wonseok Lee on 2021/06/14.
//

import UIKit

extension UICollectionViewCell {
    //MARK: - cell 내에서 자신의 index 파악하기
    func getTableCellIndexPath() -> Int {
        var indexPath = 0
        
        guard let superView = self.superview as? UICollectionView else {
            return -1
        }
        indexPath = superView.indexPath(for: self)!.row

        return indexPath
    }
}
