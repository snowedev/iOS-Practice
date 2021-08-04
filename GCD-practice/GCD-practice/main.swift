//
//  main.swift
//  GCD-practice
//
//  Created by Wonseok Lee on 2021/07/29.
//

import Foundation
let wsQueue = DispatchQueue(label: "ws")

// MARK: - Serial && sync
//wsQueue.sync {
//    for i in 1...5 {
//            print(i)
//        }
//        print("==================")
//}
//
//for i in 100...105 {
//        print(i)
//    }
//    print("==================")

// MARK: - Concurrent && sync
//DispatchQueue.global().sync {
//    for i in 1...5 {
//            print(i)
//        }
//        print("==================")
//}
//
//for i in 100...105 {
//        print(i)
//    }
//    print("==================")


// MARK: - Concurrent && async
//DispatchQueue.global().async {
//    for i in 1...5 {
//        print("\(i)🚀")
//    }
//    print("==================")
//}
//DispatchQueue.global().async {
//    for i in 200...205 {
//        print("\(i)🥕")
//    }
//    print("==================")
//}
//
//for i in 100...105 {
//    print("\(i)👻")
//}

// MARK: - Serial && async
//wsQueue.async {
//    for i in 1...5 {
//        print("\(i)🚀")
//    }
//    print("==================")
//}
//wsQueue.async {
//    for i in 200...205 {
//        print("\(i)🥕")
//    }
//    print("==================")
//}
//
//for i in 100...105 {
//    print("\(i)👻")
//}

// MARK: - ConCurrent && async + sync
//DispatchQueue.global().async {
//    for i in 1...5 {
//        print("\(i)🚀")
//    }
//    print("==================")
//}
//
//DispatchQueue.global().sync {
//    for i in 200...205 {
//        print("\(i)🥕")
//    }
//    print("==================")
//}
