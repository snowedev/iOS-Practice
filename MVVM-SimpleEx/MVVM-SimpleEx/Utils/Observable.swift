//
//  Observable.swift
//  MVVM-SimpleEx
//
//  Created by Wonseok Lee on 2021/11/02.
//

import Foundation

final class Observable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            print("didSet >>>>",value)
            listener?(value)
        }
    }
    init(_ value: T) {
        print("Observable Init >>>>",value)
        self.value = value
    }
    
    func bind(ls: Listener?) {
        self.listener = ls
        listener?(value)
    }
}
