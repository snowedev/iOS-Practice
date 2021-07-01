//
//  testData.swift
//  test-tableView
//
//  Created by Wonseok Lee on 2021/06/30.
//

import Foundation

struct MainData {
    static var sharedInstance = Array<Test>()
}

struct Test {
    let content: String
}
