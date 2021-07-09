//
//  Test.swift
//  prepareForReuseTest
//
//  Created by Wonseok Lee on 2021/07/10.
//

import Foundation

class Test {
    static let shared = Test()
    var switchData = [
        false,false,false,false,false,
        false,false,false,false,false,
        false,false,false,false,false,
        false,false,false,false,false,
        false,false,false,false,false,
        false,false,false,false,false,
        false,false,false,false,false,
        false,false,false,false,false]
    
    private init() {}
}

