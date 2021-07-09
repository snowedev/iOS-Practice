//
//  ReusableView.swift
//  CommonlyUsedStorage
//
//  Created by Wonseok Lee on 2021/07/09.
//
import UIKit

protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}
