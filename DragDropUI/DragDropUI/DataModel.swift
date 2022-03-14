//
//  DataModel.swift
//  DragDropUI
//
//  Created by Wonseok Lee on 2022/03/14.
//

import UIKit

enum Section: CaseIterable {
	case main
	case favorite
}

enum CellSize {
	case twoByOne, oneByOne
}

struct ColorModel: Hashable {
	let color: UIColor
	let size: CellSize
	let id = UUID()
}

extension ColorModel {
	static var data = [
		ColorModel(color: .systemRed, size: .oneByOne),
		ColorModel(color: .systemBlue, size: .oneByOne),
		ColorModel(color: .systemCyan, size: .twoByOne),
		ColorModel(color: .systemPink, size: .twoByOne),
		ColorModel(color: .systemBrown, size: .oneByOne),
		ColorModel(color: .systemMint, size: .oneByOne),
		ColorModel(color: .systemPurple, size: .oneByOne),
		ColorModel(color: .systemYellow, size: .oneByOne),
		ColorModel(color: .systemGreen, size: .twoByOne),
	]
	
	static var secdata = [
		ColorModel(color: .black, size: .twoByOne),
		ColorModel(color: .black, size: .oneByOne),
		ColorModel(color: .black, size: .oneByOne),
		ColorModel(color: .black, size: .twoByOne),
		ColorModel(color: .black, size: .twoByOne)
	]
}
