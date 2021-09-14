//
//  CAFETI.swift
//  URLSession+Caching
//
//  Created by Wonseok Lee on 2021/09/13.
//

import Foundation

// MARK: - Welcome
struct CAFETI: Codable {
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let cafetiIdx: Int
    let type, modifier, modifierDetail: String
    let img, plainImg: String
}
