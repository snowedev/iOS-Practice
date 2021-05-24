//
//  main.swift
//  ObserverPattern
//
//  Created by 이원석 on 2021/05/24.
//

import Foundation

// MARK: -Observerable Protocol
protocol Observer {
    var id: Int { get }
    func update()
}

class Subject {
    private var observerArray = [Observer]()
    private var _number = Int()
    
    // number변수가 초기화되면 notify
    var number: Int {
        set {
            _number = newValue
            notify()
        }
        get {
            return _number
        }
    }
    
    // 옵저버 등록
    func attachObserver(observer: Observer) {
        observerArray.append(observer)
    }
    
    // 등록된 옵저버들에게 notify
    private func notify() {
        for observer in observerArray {
            observer.update()
        }
    }
}

// 2진수 변환
class BinaryObserver: Observer {
    private var subject = Subject()
    var id = Int()
    
    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self) // 옵저버 등록
        self.id = id
    }
    
    func update() {
        print("\(subject.number)의 2진수 변환: \(String(subject.number, radix:2))")
    }
}

// 16진수 변환
class HexObserver: Observer {
    private var subject = Subject()
    var id = Int()
    
    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self) // 옵저버 등록
        self.id = id
    }
    
    func update() {
        print("\(subject.number)의 16진수 변환: \(String(subject.number, radix:16))")
    }
}


// 8진수 변환
class OctaObserver: Observer {
    private var subject = Subject()
    var id = Int()
    
    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self) // 옵저버 등록
        self.id = id
    }
    
    func update() {
        print("\(subject.number)의 8진수 변환: \(String(subject.number, radix:8))")
    }
}


let subject = Subject()

let binary = BinaryObserver(subject: subject, id: 1)
let octa = OctaObserver(subject: subject, id: 2)
let hex = HexObserver(subject: subject, id: 3)

subject.number = 15
subject.number = 2
