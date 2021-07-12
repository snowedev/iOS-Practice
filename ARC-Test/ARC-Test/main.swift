//
//  main.swift
//  ARC-Test
//
//  Created by Wonseok Lee on 2021/07/12.
//

import Foundation

// 클래스의 인스턴스가 생성될 때와 해지될 때 로그 출력
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Appleseed")
// Person 인스턴스 생성, RC = 1
// Prints "John Appleseed is being initialized"

reference2 = reference1
reference3 = reference1
// Person 인스턴스 RC = 3

reference1 = nil
reference2 = nil
// Person 인스턴스 RC = 1

reference3 = nil
// Person 인스턴스 RC = 0, 메모리 해지
// Prints "John Appleseed is being deinitialized"
